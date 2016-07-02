require_relative './revc'

class Rosalind

  def self.mmch inputo
    rna = fasta(inputo).values.first
    a, u, g, c = %w{A U G C}.map { |x| rna.count(x) }

    count_fingers(a, u) * count_fingers(c, g)
  end

  def self.count_fingers a, b
    min, max = [a, b].sort
    (1..max).to_a.reverse[0...min].reduce(:*)
  end

end

# took forever to figure out. draw and count A A A U U U U U U (3:6)
# 3.times { multiple from 6 downwards }
