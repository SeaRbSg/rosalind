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

  def run s
    puts dna_to_rna parse s
  end
end

if __FILE__ == $0 then
  Rosalind.new.run ARGF.read
end
