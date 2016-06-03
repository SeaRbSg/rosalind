require_relative './dna'

class Rosalind

  def self.rna dna_str
    dna_str.gsub('T', 'U')
  end

end
