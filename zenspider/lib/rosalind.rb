require "extensions"

class Rosalind
  def run args
    ARGV.each do |path|
      name = path.split(/[_.]/)[1]
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

  def cmd_hamm s
    a, b = s.lines.map(&:chomp)
    hamm a, b
  end

  def cmd_iprb s
    k, m, n = s.integers
    recessive k, m, n
  end

  def cmd_mrna s
    counts = RNA_CODON.values.counts

    "#{s}.".chars.inject(1) { |n, c| (n * counts[c]) % 1_000_000 }
  end

  def cmd_mprt s
    prots = proteins s.words

    grep_protein prots, /N[^P][ST][^P]/
  end

  def cmd_perm s
    n = s.to_i
    p = 1.upto(n).to_a.permutation
    [p.size, p.map { |a| a.join " " }]
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

  def cmd_rna s
    dna_to_rna s
  end

  def cmd_subs s
    s, t = s.lines.map(&:chomp)
    s.indicies(t).join " "
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

  def count_dna dna
    DNA.keys.map { |nt| dna.count nt }
  end

  def dna_to_rna dna
    dna.tr "T", "U"
  end

  def fasta s
    Hash[*s.split(/^>([^\n]+)\n/).drop(1).map { |ss| ss.delete("\n") }]
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

  def gc fasta
    fasta.map { |k, v| [k, gc_content(v)] }.max_by { |k,v| v }
  end

  def gc_content dna
    100.0 * dna.delete("AT").size / dna.size
  end

  def grep_protein prots, re
    prots.flat_map { |id, prots|
      prots.values.map { |s|
        r = s.indicies(re)
        next if r.empty?
        [id, r.join(" ")]
      }
    }.compact
  end

  def hamm a, b
    a.chars.zip(b.chars).count { |m, n| m != n }
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

  def triangle n
    (n * n - n) / 2
  end
end
