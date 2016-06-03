require_relative './revc'

class Rosalind

  ## prot exercise == encode protein from rna string
  def self.prot rna_str
    rna_str.scan(/.{1,3}/).map{ |s| RNA2AMIN[s] }.join
  end

  class << self
    alias_method :encode_protein, :prot
  end

end
