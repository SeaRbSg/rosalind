require_relative './mrna'

class Rosalind
  def self.pper chorizo
    n, k = chorizo.split(' ').map &:to_i

    [*(1..n)].permutation(k).size % 1_000_000
  end
end
