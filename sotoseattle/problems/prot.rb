require_relative './revc'

class Rosalind

  def self.prot rna_str
    rna_str.scan(/.{1,3}/).map{ |s| RNA2AMIN[s] }.join
  end

end
