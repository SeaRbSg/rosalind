module Helpers
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

  @@subsequence = {}

  def subsequence a, b
    @@subsequence[[a, b]] ||=
    case
    when a.empty? || b.empty? then
      ""
    when a[0] == b[0] then
      a[0] + subsequence(a[1..-1], b[1..-1])
    else
      c = subsequence(a[1..-1], b)
      d = subsequence(a, b[1..-1])

      [c, d].max_by(&:size)
    end
  end

  def triangle n
    (n * n - n) / 2
  end
end
