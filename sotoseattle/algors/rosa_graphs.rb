require 'set'

class RosaGraph

  attr_accessor :g

  def initialize inputo
    nk, *edges = inputo.split("\n").map { |s| s.split.map(&:to_i) }
    @g = {}
    (1..nk.first).each { |n| g[n] = Set.new }
    edges
  end

  def dive node, path
    g[node].each do |o|
      next if path.include? o
      dive o, path << o
    end
    path
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
    g.keys.count { |n| dive(n, accum) unless accum.include?(n) }
  end

  def fixed_cycle? node, path, cycle_length
    g[node].each do |o|
      if path.include?(o)
        return true if path[-cycle_length] == o
        next
      end

      return true if fixed_cycle?(o, path +[o], cycle_length)
    end
    false
  end

  def square_cycled?
    g.keys.any? { |n| fixed_cycle?(n, [], 4) }
  end
end

class DirGraph < RosaGraph

  def initialize inputo
    super(inputo).each { |from, to| g[from] << to }
  end

  def acyclic?
    g.keys.none? { |n| dive(n, []).include?(n) }
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
    batch_graphs inputo, UndirGraph, :square_cycled?
  end
end

