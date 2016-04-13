class Rosalind
  def run args
    name = args.first.split(/[_.]/)[1]
    puts send("cmd_#{name}", parse(ARGF.read))
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

  def cmd_dna s
    count_dna(s).join " "
  end

  def cmd_rna s
    dna_to_rna s
  end

  def cmd_revc s
    reverse_compliment s
  end

  def count_dna dna
    %w[A C G T].map { |nt| dna.count nt }
  end

  def dna_to_rna dna
    dna.tr "T", "U"
  end

  def reverse_compliment dna
    dna.reverse.tr "ATCG", "TAGC"
  end
end
