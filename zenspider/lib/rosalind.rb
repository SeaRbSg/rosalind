class Rosalind
  def run args
    ARGV.each do |path|
      name = path.split(/[_.]/)[1]
      warn "# #{name}"
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

  def cmd_dna s
    count_dna(s).join " "
  end

  def cmd_fib s
    fib(*s.scan(/\d+/).map(&:to_i))
  end

  def cmd_gc s
    gc fasta s
  end

  def cmd_prot s
    rna_to_prot s
  end

  def cmd_revc s
    reverse_compliment s
  end

  def cmd_rna s
    dna_to_rna s
  end

  def cmd_subs s
    s, t = s.lines.map(&:chomp)
    indicies(s, t).join " "
  end

  def indicies s, t
    idx, hits = 0, []
    while idx = s.index(t, idx) do
      idx += 1
      hits << idx
    end
    hits
  end

  ##
  # Helpers

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

  RNA_CODON = Hash[*rna_table.scan(/\S+/)]

  def count_dna dna
    %w[A C G T].map { |nt| dna.count nt }
  end

  def dna_to_rna dna
    dna.tr "T", "U"
  end

  def fasta s
    Hash[*s.split(/^>(\w+)\n/).drop(1).map { |ss| ss.delete("\n") }]
  end

  def fib n, k
    a, b = 0, 1
    n.times do
      a, b = b, k * a + b
    end
    a
  end

  def gc fasta
    fasta.map { |k, v| [k, gc_content(v)] }.max_by { |k,v| v }
  end

  def gc_content dna
    100.0 * dna.delete("AT").size / dna.size
  end

  def reverse_compliment dna
    dna.reverse.tr "ATCG", "TAGC"
  end

  def rna_to_prot rna
    rna.gsub(/.../, RNA_CODON)
  end
end
