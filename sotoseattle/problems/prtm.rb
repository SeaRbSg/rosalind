require_relative './prot'

class Rosalind

  def self.prtm protein_strand
    protein_strand.chomp.chars.map{ |amino| AMINO_MASS[amino] }.reduce :+
  end

end
