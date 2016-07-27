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

class Graph
  attr_accessor :graph

  def initialize edges
    self.graph = Hash.new { |h, k| h[k] = [] }

    init_from_edges edges
  end

  def init_from_edges edges
    edges.each do |from, to|
      graph[from] << to
      graph[to]
    end
  end

  def nodes
    graph.keys
  end

  def all_distances start
    queue            = [start]
    distances        = Hash.new(-1)
    distances[start] = 0

    until queue.empty? do
      current = queue.shift

      graph[current].each do |neighbor|
        if distances[neighbor] == -1 then
          queue << neighbor
          distances[neighbor] = distances[current] + 1
        elsif distances[current] + 1 < distances[neighbor] then
          queue << neighbor
          distances[neighbor] = distances[current] + 1
        end
      end
    end

    distances
  end

  def distance start, finish
    queue = [[start, 0]]
    seen  = {start => true}

    until queue.empty?
      current, distance = queue.shift

      seen[current] = true

      return distance if current == finish

      graph[current].each do |neighbor|
        next if seen[neighbor]
        queue << [neighbor, distance + 1]
      end
    end

    -1
  end
end


edges = File.read("bfs.txt").split("\n").map { |l| l.split(/\s/).map(&:to_i) }
max, _ = edges.shift

g         = Graph.new edges
distances = g.all_distances(1)

puts (1..max).map{ |n| distances[n] }.join(' ')
