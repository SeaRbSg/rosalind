require "matrix"
require "tsort"

class DirectedGraph
  include TSort

  attr_accessor :graph, :node_count

  def self.from_edge_list edge_list
    node_count, edge_count = edge_list.shift

    edges = []
    edge_count.times do
      edges << edge_list.shift
    end

    g = self.new edges, node_count
  end

  def initialize edges, node_count
    self.node_count = node_count
    self.graph = Hash.new { |h, k| h[k] = [] }

    init_from_edges edges
  end

  def init_from_edges edges
    edges.each do |from, to|
      graph[from]
      graph[to] << from
    end
  end

  def nodes
    graph.keys
  end

  # def edge? from, to
  #   graph[to].include? from
  # end

  def tsort_each_node(&block)
    (1..node_count).each(&block)
  end

  def tsort_each_child(node, &block)
    graph[node].each(&block)
  end

  # def all_distances start
  #   queue            = [start]
  #   distances        = Hash.new(-1)
  #   distances[start] = 0

  #   until queue.empty? do
  #     current = queue.shift

  #     graph[current].each do |neighbor|
  #       if distances[neighbor] == -1 then
  #         queue << neighbor
  #         distances[neighbor] = distances[current] + 1
  #       end
  #     end
  #   end

  #   distances
  # end

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

  # def adjacency_matrix
  #   m = Matrix.build(node_count, node_count) do |row, col|
  #     graph[row + 1].include?(col + 1) ? 1 : 0
  #   end

  #   m
  # end

  def acyclic?
    self.tsort
  rescue TSort::Cyclic
    return false
  end
end
