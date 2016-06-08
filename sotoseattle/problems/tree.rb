require_relative './tree'

class Rosalind

  def self.tree inputo
    n, *nodes = inputo.split(/\n/).map { |x| x.split.map &:to_i }

    n.first - nodes.count - 1
  end

end
