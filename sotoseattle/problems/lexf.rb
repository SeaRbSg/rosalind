require_relative './perm'

class Rosalind

  def self.lexf inputo
    a, b = inputo.split("\n")
    alpha = a.split(" ")
    n = b.to_i

    alpha.repeated_permutation(n).map(&:join).join("\n") + "\n"
  end

end
