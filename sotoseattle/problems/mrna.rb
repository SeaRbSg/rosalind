require_relative './prot'

class Rosalind

  ## mrna == number of rna strings that could have been source for protein
  def self.mrna protein_str
    input = protein_str.chomp + EOS

    translator = RNA2AMIN.to_a.group_by &:last

    input.chars.map{|c| translator[c].size }.reduce(:*) % 1_000_000
  end

end
