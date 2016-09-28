require "matrix"

class DirectedGraph
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
      graph[from] << to
      graph[to]
    end
  end

  def nodes
    graph.keys
  end

  def edge? from, to
    graph[from].include? to
  end

  def topological_sort
    ## Generate InDegree Hash
    indegrees = Hash.new(0)

    graph.each do |_, neighbors|
      neighbors.each do |n|
        indegrees[n] += 1
      end
    end

    ## Find all nodes with indegree zero and add them to a stack
    stack = []
    nodes.each do |n|
      stack << n if indegrees[n] == 0
    end

    sorted = []

    until stack.empty? do
      current = stack.pop
      sorted << current

      graph[current].each do |n|
        indegrees[n] -= 1
        stack << n if indegrees[n] == 0
      end
    end
    sorted
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

  def adjacency_matrix
    m = Matrix.build(node_count, node_count) do |row, col|
      graph[row + 1].include?(col + 1) ? 1 : 0
    end

    m
  end

  def acyclic?
    # Find a node that does not have any incoming edges
    # Columns with no 1s in the adjacency matrix correspond to nodes
    # with no incoming edges.
    node = nil

    graph.each_key do |n|
      next if graph.values.any? { |v| v.include? n }
      node = n
      break
    end

    return false unless node

    # Start a DFS search on that node, when you go to add a node see
    # if you've already visited it (it is already on the stack, if so,
    # there's a cycle.
    stack = [[node, []]]

    until stack.empty? do
      current, path = stack.pop

      p = path + [current]

      graph[current].each do |neighbor|
        return false if p.include?(neighbor)
        stack << [neighbor, p]
      end
    end

    return true
  end
end
