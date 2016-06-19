require_relative './perm'

class Rosalind

  def self.lexf inputo
    a, b = inputo.split("\n")
    alpha, n = a.split, b.to_i

    alpha.repeated_permutation(n).map(&:join).join("\n")

    # unnecessary
    # .sort_by { |a, b| alpha.index(a) <=> alpha.index(b) }
  end

end
