require_relative './tree'

class Rosalind

  def self.sset n
    (2 ** n) % 1_000_000
  end

end
