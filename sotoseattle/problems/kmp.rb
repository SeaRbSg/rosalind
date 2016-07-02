require_relative './revc'

class Rosalind

  def self.kmp inputo
    strand = fasta(inputo).values.first
    failure = Array.new(strand.size, 0)

    (1...strand.size).each do |i|
      kk = find_substrand(strand, strand[0,i]) - [1]
      kk.each { |x| failure[x-2+i] = i }
    end

    failure.join ' '
  end

end
