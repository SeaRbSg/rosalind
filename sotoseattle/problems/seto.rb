require_relative './revc'
require 'set'

class Rosalind

  def self.seto inputo
    n, a, b = inputo.split("\n")

    a, b  = unpako(a), unpako(b)
    u = (1..n.to_i).to_set

    [a | b, a & b, a - b, b - a, u - a, u - b].map {|x| pako(x)}.join("\n")
  end

  def self.unpako str
    str.delete('{,}').split.map(&:to_i).to_set
  end

  def self.pako s
    '{' + s.to_a.join(', ') + '}'
  end

end
