require 'set'

class RosaGraph

  attr_accessor :g

  def initialize inputo
    nk, *edges = inputo.split("\n").map { |s| s.split.map(&:to_i) }
    @g = {}
    (1..nk.first).each { |n| g[n] = Set.new }
    edges
  end

  def dfs_path node, path
    g[node].each do |o|
      next if path.include? o
      dfs_path o, path << o
    end
    path
  end

  def dfs_query node, path, question
    g[node].each do |o|
      if path.include? o
        return true if question.call path, o
        next
      end

      return dfs_query o, path + [o], question
    end
    false
  end

end

class UndirGraph < RosaGraph

  def initialize inputo
    super(inputo).each { |a, b| g[b] << a && g[a] << b }
  end

  def deg
    g.keys.map { |n| g[n].size }.join(" ")
  end

  def ddeg
    g.keys.map { |n| g[n].reduce(0) { |t, m| t += g[m].size } }.join(" ")
  end

  def cc
    accum = []
    g.keys.count { |n| dfs_path(n, accum) unless accum.include?(n) }
  end

  def squared?
    query = lambda {|p, o| p[-4] == o}
    g.keys.any? { |n| dfs_query n, [], query }
  end

  def bipartite?
    query = lambda {|p, o| (p.size - p.index(o)).odd?}
    g.keys.none? { |n| dfs_query n, [], query }
  end
end

class DirGraph < RosaGraph

  def initialize inputo
    super(inputo).each { |from, to| g[from] << to }
  end

  def acyclic?
    g.keys.none? { |n| dfs_path(n, []).include? n }
  end

  def ts
    nodes, n = g.keys, nil
    nodes.map do
      nodes -= [n]
      children = nodes.map{ |o| g[o].to_a }.flatten.uniq
      parents  = nodes - children
      n = parents.first
    end.join(" ")
  end
end

class RosalindGraphs
  def self.batch_graphs inputo, g_type, question
    inputo.split("\n\n").drop(1).map { |g| g_type.new(g).send(question) ? 1 : -1 }.join(" ")
  end

  def self.dag inputo
    batch_graphs inputo, DirGraph, :acyclic?
  end

  def self.sq inputo
    batch_graphs inputo, UndirGraph, :squared?
  end

  def self.bip inputo
    batch_graphs inputo, UndirGraph, :bipartite?
  end
end

