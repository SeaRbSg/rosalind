require "extensions"

class Rosalind
  def run args
    ARGV.each do |path|
      name = path.split(/[_.]/)[1]
      name = File.basename path, ".txt" if name.empty?
      warn "# #{name}: #{path}"
      puts send("cmd_#{name}", parse(File.read(path)))
    end
  end

  def parse s
    s.each_line.map { |l|
      case l
      when /^\s*#|^$/ then
        next
      else
        l.chomp
      end
    }.compact.join "\n"
  end

  ##
  # Commands

  def cmd_cons s
    profile   = profile s
    consensus = consensus profile
    profile   = DNA.keys.map { |c| "#{c}: #{profile.map { |h| h[c] }.join(" ")}" }
    [consensus, *profile]
  end

  def cmd_dna s
    count_dna(s).join " "
  end

  def cmd_fib s
    fib(*s.integers)
  end

  def cmd_fibd s
    n, m = s.integers

    fibd n, m
  end

  def cmd_gc s
    gc fasta s
  end

  def cmd_grph s
    dnas = fasta s

    h = HashHashArray.new

    dnas.each do |k, v|
      pre, suf = v[0,3], v[-3,3]
      h[pre][:pre] << k
      h[suf][:suf] << k
    end

    h.flat_map { |_, v| v[:suf].product v[:pre] }.reject(&:paireq).map(&:spc)
  end

  def cmd_hamm s
    a, b = s.lines.map(&:chomp)
    hamm a, b
  end

  def cmd_inod s
    n = s.integers.first

    n - 2
  end

  def cmd_iprb s
    k, m, n = s.integers
    recessive k, m, n
  end

  def cmd_lcsm s
    first, *rest = fasta(s).values

    first.length.downto(2).each do |n|
      v = first.each_cons(n).find { |sub| rest.all? { |ss| ss.include? sub } }
      return v if v
    end
  end

  def cmd_lexf s
    a = s.words
    l = a.pop.to_i

    a.repeated_permutation(l).map(&:join)
  end

  def cmd_lexv s
    d = s.words
    l = d.pop.to_i

    a = (1..l).flat_map { |n| d.repeated_permutation(n).to_a.map(&:join) }

    a.sort_by_dict d
  end

  def cmd_lgis s
    max, *ary = s.integers

    a = lgis(ary).join " "
    b = lgis(ary.reverse).reverse.join " "
    [a, b]
  end

  def cmd_lia s
    m, n = s.integers

    m = 2**m

    (n..m).inject(0.0) { |r, i| r + m.c(i) * 0.25**i * 0.75**(m - i) }
  end

  def cmd_long s
    candidates = fasta(s).values

    candidates.flat_map.with_index { |first, i|
      warn "%d/%d" % [i+1, candidates.size]
      rest = candidates-[first]
      find_joins first, rest
    }.compact
  end

  def cmd_mrna s
    counts = RNA_CODON.values.counts

    "#{s}.".chars.inject(1) { |n, c| (n * counts[c]) % 1_000_000 }
  end

  def cmd_mprt s
    prots = proteins s.words

    grep_protein prots, /N[^P][ST][^P]/
  end

  def cmd_orf s
    dna = fasta_string s

    dna_to_prots(dna).uniq
  end

  def cmd_perm s
    n = s.to_i
    p = 1.upto(n).to_a.permutation
    [p.size, p.map { |a| a.join " " }]
  end

  def cmd_pmch s
    rna = fasta_string s

    count = count_chars(rna)

    count["A"].fact * count["G"].fact
  end

  def cmd_pper s
    m, n = s.integers

    m.p(n) % 1_000_000
  end

  def cmd_prob s
    dna, *probs = s.words

    prob(dna, probs.map(&:to_f)).map { |f| "%.3f" % f }.join " "
  end

  def cmd_prot s
    rna_to_prot s
  end

  def cmd_prtm s
    "%.3f" % s.chars.map { |c| AA_WEIGHT[c] }.sum
  end

  def cmd_revc s
    reverse_compliment s
  end

  def cmd_revp s
    s = fasta_string s

    (4..12).flat_map { |length|
      s.each_cons(length).with_index.map { |ss, i|
        "#{i+1} #{length}" if ss == reverse_compliment(ss)
      }
    }.compact
  end

  def cmd_rna s
    dna_to_rna s
  end

  def cmd_seto s
    n, a, b = s.delete("{}").lines
    n = n.to_i
    a = a.integers
    b = b.integers
    s = (1..n).to_a

    [a | b, a & b, a - b, b - a, s - a, s - b].map(&:to_str_mathy)
  end

  def cmd_sseq s
    dna, pat = fasta(s).values

    indicies(dna, pat).join " "
  end

  def cmd_sset s
    n = s.integers.first

    (2 ** n) % 1_000_000
  end

  def cmd_sign s
    n = s.integers.first

    perms = signed_permutation n

    [perms.length, perms.map { |a| a.join " " }]
  end

  def cmd_splc s
    h = fasta s

    dna = h.delete h.keys.first
    dna.gsub! Regexp.union(*h.values), ""

    rna_to_prot dna_to_rna dna
  end

  def cmd_subs s
    s, t = s.lines.map(&:chomp)
    s.indicies(t).join " "
  end

  def cmd_tran s
    s1, s2 = fasta(s).values

    a, b = count_mutations s1, s2

    a / b
  end

  def cmd_tree s
    max, *edges = s.integers

    max - (edges.size/2) - 1
  end

  ##
  # Helpers

  DNA = { "A" => 0, "C" => 1, "G" => 2, "T" => 3 }

  aa_weight = <<-END_AA.words.each_slice(2).flat_map { |a, n| [a, n.to_f] }
    A  71.03711 C 103.00919 D 115.02694 E 129.04259
    F 147.06841 G  57.02146 H 137.05891 I 113.08406
    K 128.09496 L 113.08406 M 131.04049 N 114.04293
    P  97.05276 Q 128.05858 R 156.10111 S  87.03203
    T 101.04768 V  99.06841 W 186.07931 Y 163.06333
  END_AA

  AA_WEIGHT = Hash[*aa_weight]

  rna_table = <<-END_RNA
     UUU F CUU L AUU I GUU V
     UUC F CUC L AUC I GUC V
     UUA L CUA L AUA I GUA V
     UUG L CUG L AUG M GUG V
     UCU S CCU P ACU T GCU A
     UCC S CCC P ACC T GCC A
     UCA S CCA P ACA T GCA A
     UCG S CCG P ACG T GCG A
     UAU Y CAU H AAU N GAU D
     UAC Y CAC H AAC N GAC D
     UAA . CAA Q AAA K GAA E
     UAG . CAG Q AAG K GAG E
     UGU C CGU R AGU S GGU G
     UGC C CGC R AGC S GGC G
     UGA . CGA R AGA R GGA G
     UGG W CGG R AGG R GGG G
   END_RNA

  RNA_CODON = Hash[*rna_table.words]
  DNA_CODON = Hash[*rna_table.tr("U", "T").words]

  def cache id
    path = "tmp/#{id}"
    unless File.exist? path then
      File.open path, "w" do |f|
        f.write yield
      end
    end
    File.read path
  end

  def consensus profile
    profile.map { |h| h.max_by(&:last) }.map(&:first).join
  end

  def count_chars s
    Hash[s.chars.group_by(&:itself).map { |k, v| [k, v.size] }]
  end
  # TODO: refactor count_dna to use count_chars?

  def count_dna dna
    DNA.keys.map { |nt| dna.count nt }
  end

  def count_mutations s1, s2
    transitions = 0.0
    transversions = 0.0

    s1.chars.zip(s2.chars).each do |c1, c2|
      next if c1 == c2

      if "#{c1}#{c2}" =~ /AG|GA|CT|TC/ then
        transitions += 1
      else
        transversions += 1
      end
    end

    [transitions, transversions]
  end

  def dna_to_prot dna
    dna.gsub(/.../, DNA_CODON)
  end

  def dna_to_prots dna
    rdna = reverse_compliment dna
    dna << "\n" << rdna

    dna.each_slice { |s| dna_to_prot(s).scan(/^(M[^.\n]*)\./) }.flatten
  end

  def dna_to_rna dna
    dna.tr "T", "U"
  end

  def fasta s
    Hash[*s.split(/^>([^\n]+)\n/).drop(1).map { |ss| ss.delete("\n") }]
  end

  def fasta_string s
    h = fasta s
    raise ArgumentError, "More than one fasta string" unless h.size == 1
    h.values.first
  end

  def fib n, k
    a, b = 0, 1
    n.times do
      a, b = b, k * a + b
    end
    a
  end

  def fibd n, m
    a = [0] * m
    a[0] = 1
    n.pred.times do
      a = [a[1..-1].sum] + a[0..-2]
    end
    a.sum
  end

  def find_joins first, rest
    return first if rest.empty?

    rest.flat_map { |str|
      min = str.size / 2
      max = str.size - 1
      substrs = max.downto(min).map { |len| str[0..len] }

      found = substrs.find { |substr| first.end_with? substr }

      find_joins first+str[found.size..-1], rest-[str] if found
    }
  end

  def gc fasta
    fasta.map { |k, v| [k, gc_content(v)] }.max_by { |k,v| v }
  end

  def gc_content dna
    100.0 * dna.delete("AT").size / dna.size
  end

  def grep_protein prots, re
    prots.flat_map { |id, prot|
      prot.values.map { |s|
        r = s.indicies(re)
        next if r.empty?
        [id, r.join(" ")]
      }
    }.compact
  end

  def hamm a, b
    a.chars.zip(b.chars).count { |m, n| m != n }
  end

  def indicies s, p
    idx = 0

    p.chars.map { |c|
      idx = s.index(c, idx) + 1
    }
  end

  def lgis ary
    #  * Dynamic Programming is used to solve this question. DP equation is
    #  * if(arr[i] > arr[j]) { T[i] = max(T[i], T[j] + 1 }

    len = Array.new ary.size, 1
    sol = (0...ary.size).to_a

    (1...ary.size).each do |i|
      (0...i).each do |j|
        if ary[i] > ary[j] then
          if len[j]+1 > len[i] then
            len[i] = len[j] + 1
            sol[i] = j
          end
        end
      end
    end

    max = (0...len.size).max_by { |n| len[n] }

    new_t = t_idx = max

    a = []
    begin
      t_idx = new_t
      a.unshift ary[t_idx]
      new_t = sol[t_idx]
    end while t_idx != new_t

    a
  end

  def prob dna, probs
    a, c, g, t = count_dna dna
    cg = c + g
    at = a + t

    probs.map { |p|
      m, n = p / 2, (1-p) / 2

      # log(m * n) == log(m) + log(n)
      Math.log10(m ** cg) + Math.log10(n ** at)
    }
  end

  def profile s
    dnas = fasta(s).values

    profile = Array.new(dnas.first.size) { Hash.new 0 }

    dnas.each do |dna|
      dna.chars.each_with_index do |c, i|
        profile[i][c] += 1
      end
    end

    profile
  end

  def proteins ids
    ids.map { |id|
      short_id = id.sub(/_.*$/, "")
      protein = cache short_id do
        `curl http://www.uniprot.org/uniprot/#{short_id}.fasta`
      end


      [id, fasta(protein)]
    }
  end

  ##
  # bb handshakes / total handshakes
  #
  # given 2 BB, 2 Bb, 2 bb:
  #
  #    lhs   mid   rhs
  #
  #        B     B
  #        B     B
  #        B     b 0
  #        B     b 1
  #      0 b  3  b 2
  #      1 b  3  b 3
  #
  # tri(n) + xxx + tri(m+n)    where    xxx = n*(m+n)-n
  #      1 +  6  + 6
  #             = 13 / 60 => 0.21666

  def recessive k, m, n
    all = k + m + n
    mix = m + n
    total = 4.0 * triangle(all) # 2 * squareish all = 2 * 2 * triangle all

    lhs = triangle n
    mid = n * mix - n
    rhs = triangle mix

    1 - (lhs+mid+rhs) / total
  end

  def reverse_compliment dna
    dna.reverse.tr "ATCG", "TAGC"
  end

  def rna_to_prot rna
    rna.gsub(/.../, RNA_CODON)
  end

  def signed_permutation n
    depth = 2 ** n

    perms = 1.upto(n).to_a.permutation

    perms.flat_map { |nums|
      depth.times.map { |bits|
        signs = nums.length.times.map { |i| bits[i].zero? ? 1 : -1 }
        nums.zip(signs).map { |(a, b)| a * b }
      }
    }
  end

  def triangle n
    (n * n - n) / 2
  end
end
