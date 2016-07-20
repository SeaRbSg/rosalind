require 'set'

class RosaGraph

  attr_accessor :g

  def initialize inputo
    nk, *edges = inputo.split("\n").map { |s| s.split.map(&:to_i) }
    @g = {}
    (1..nk.first).each { |n| @g[n] = Set.new }
    edges
  end

  def dive node, path
    @g[node].each do |o|
      next if path.include? o
      dive o, path << o
    end
    path
  end
end

class UndirGraph < RosaGraph

  def initialize inputo
    super(inputo).each { |a, b| @g[b] << a && @g[a] << b }
  end

  def deg
    @g.keys.map { |n| @g[n].size }.join(" ")
  end

  def ddeg
    @g.keys.map { |n| @g[n].reduce(0) { |t, m| t += @g[m].size } }.join(" ")
  end

  def cc
    accum = []
    @g.keys.count { |n| dive(n, accum) unless accum.include?(n) }
  end
end

class DirGraph < RosaGraph

  def initialize inputo
    super(inputo).each { |from, to| @g[from] << to }
  end

  def cyclic?
    @g.keys.any? { |n| dive(n, []).include? n }
  end
end

class RosalindGraphs
  def self.dag inputo
    inputo.split("\n\n").drop(1)
          .map { |g| DirGraph.new(g).cyclic? ? -1 : 1 }.join(" ")
  end
end

