require_relative './revc'

class Rosalind

  def self.pdst inputo
    strands = fasta(inputo).values
    strands.map { |i| strands.map { |j| pdist(i, j).round(4) }.join(' ') }.join("\n")
  end

  def self.pdist a, b
    1.0 * hamming_distance(a, b) / a.size
  end

end
