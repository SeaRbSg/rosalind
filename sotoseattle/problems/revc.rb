require_relative './rna'

class Rosalind

  def self.compl str
    str.chars.map{ |x| NUCLEOTIDS[x] }.join
  end

  def self.revc dna_str
    compl dna_str.reverse
  end

end

