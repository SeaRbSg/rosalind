require_relative './prot'

class Rosalind

  def self.congruent? a, b, n
    a % n == b % n
  end

  def self.amin_2_rna
    h = {}
    RNA2AMIN.each do |k, v|
      if h[v]
        h[v] << k
      else
        h[v] = [k]
      end
    end
    h
  end

  def self.mrna protein_str
    input = protein_str.chomp + EOS

    translator = amin_2_rna
    input.chars.map{|c| translator[c].size }.reduce(:*) % 1_000_000
  end

end
