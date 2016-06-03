require_relative './prot'

class Rosalind

  ## prtm exercise == total weight of a protein
  def self.prtm protein_strand
    protein_strand.chomp.chars.map{ |amino| AMINO_MASS[amino] }.reduce :+
  end

  class << self
    alias_method :protein_weight, :prtm
  end

end
