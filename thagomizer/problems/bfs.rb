# Problem

# The task is to use breadth-first search to compute single-source
# shortest distances in an unweighted directed graph.

# Given: A simple directed graph with n <= 10^3 vertices in the edge
# list format.

# Return: An array D[1..n] where D[i] is the length of a shortest path
# from the vertex 1 to the vertex i (D[1]=0). If i is not reachable
# from 1 set D[i] to -1.


# Sample Dataset
# 6 6
# 4 6
# 6 5
# 4 3
# 3 5
# 2 1
# 1 4

# Sample Output
# 0 -1 2 1 3 2

require 'pry'

class Graph
  attr_accessor :edges, :graph

  def initialize edges
    self.edges = edges
    self.graph = Hash.new { |h, k| h[k] = [] }

    graph_from_edges
  end

  def graph_from_edges
    self.edges.each do |from, to|
      graph[from] << to
      graph[to]   << from
    end
  end

  def nodes
    graph.keys
  end

  def distance start, finish
    queue = [[start, 0]]
    seen  = [start]

    loop do
      current, distance = queue.shift

      return distance if current == finish

      graph[current].each do |neighbor|
        next if seen.include?(neighbor)
        queue << [neighbor, distance + 1]
      end
    end

    return -1

  end
end


edges = File.read("bfs.txt").split("\n").map { |l| l.split(/\s/).map(&:to_i) }
max, _ = edges.shift

g = Graph.new edges

puts g.nodes.sort.map { |n| g.distance(1, n) }.join(' ')
