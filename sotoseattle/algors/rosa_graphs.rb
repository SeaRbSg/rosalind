require 'set'

class RosaGraph

  attr_accessor :g

  def initialize inputo
    nk, *edges = inputo.split("\n").map { |s| s.split.map(&:to_i) }

    @g = {}
    (1..nk.first).each { |n| @g[n] = Set.new }
    edges.each { |a, b| @g[b] << a && @g[a] << b }
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

  private

  def dive node, acc
    @g[node].each do |o|
      next if acc.include? o
      dive o, acc << o
    end
    acc
  end

end
