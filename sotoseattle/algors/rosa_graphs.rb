require 'set'

class RosaGraph

  attr_accessor :g

  def initialize inputo
    nk, *edges = inputo.split("\n").map { |s| s.split.map(&:to_i) }
    @g = {}
    (1..nk.first).each { |n| g[n] = Set.new }
    edges
  end

  def nodes
    g.keys
  end

  def dfs_path node, path
    g[node].each { |o| path.include?(o) ? next : dfs_path(o, path << o) }
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
    nodes.map { |n| g[n].size }.join(" ")
  end

  def ddeg
    nodes.map { |n| g[n].reduce(0) { |t, m| t += g[m].size } }.join(" ")
  end

  def cc
    accum = []
    nodes.count { |n| dfs_path(n, accum) unless accum.include?(n) }
  end

  def squared?
    query = lambda {|p, o| p[-4] == o}
    nodes.any? { |n| dfs_query n, [], query }
  end

  def bipartite?
    query = lambda {|p, o| (p.size - p.index(o)).odd?}
    nodes.none? { |n| dfs_query n, [], query }
  end
end

class DirGraph < RosaGraph

  def initialize inputo
    super(inputo).each { |from, to| g[from] << to }
  end

  def acyclic?
    nodes.none? { |n| dfs_path(n, []).include? n }
  end

  def ts
    vrtx, o = nodes, nil
    vrtx.map do
      vrtx -= [o]
      o = (vrtx - vrtx.collect{ |n| g[n].to_a }.flatten).first
    end.join(" ")
  end
end

class RosalindGraphs
  def self.batch_graphs inputo, g_type, question
    inputo.split("\n\n").drop(1).map { |g| g_type.new(g).send(question) ? 1 : -1 }.join(" ")
  end

  def self.dag inputo; batch_graphs inputo, DirGraph,   :acyclic?;   end
  def self.sq inputo;  batch_graphs inputo, UndirGraph, :squared?;   end
  def self.bip inputo; batch_graphs inputo, UndirGraph, :bipartite?; end
end

