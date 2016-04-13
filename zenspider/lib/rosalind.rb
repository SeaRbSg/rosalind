class Rosalind
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

  def count_dna dna
    %w[A C G T].map { |nt| dna.count nt }
  end

  def dna_to_rna dna
    dna.tr "T", "U"
  end

  def reverse_compliment dna
    dna.reverse.tr "ATCG", "TAGC"
  end

  def run s
    puts reverse_compliment parse s
  end
end

if __FILE__ == $0 then
  Rosalind.new.run ARGF.read
end
