require_relative './rna'

class Rosalind

  ## revc exercise == reverse complement of a dna strand
  def self.revc dna_strand
    complement(dna_strand).reverse
  end

  class << self
    alias_method :reverse_complement, :revc
  end

  ## complement of a dna string
  def self.complement dna_strand
    dna_strand.chars.map{ |x| NUCLEIC_ACIDS[x] }.join
  end

end

