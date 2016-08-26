class Graph
  attr_accessor :graph, :node_count

  def initialize edges, node_count
    self.node_count = node_count
    self.graph = Hash.new { |h, k| h[k] = [] }

    init_from_edges edges
  end

  def init_from_edges edges
    edges.each do |from, to|
      graph[from] << to
      graph[to]   << from
    end
  end

  def nodes
    graph.keys
  end

  def components
    stack      = []
    components = Hash.new { |h, k| h[k] = [] }
    explored   = Hash.new

    1.upto(node_count) do |n|
      next if explored[n]
      stack << [n, n]
      components[n]

      until stack.empty? do
        node, component = stack.pop
        explored[node] = true

        graph[node].each do |neighbor|
          next if explored[neighbor]
          unless components[component].include?(neighbor)
            components[component] << neighbor
            stack << [neighbor, component]
          end
        end
      end
    end

    components
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
    matrix = Array.new(self.node_count + 1, [])

    1.upto(self.node_count).each do |i|
      1.upto(self.node_count).each do |j|
        if graph[i + 1].include?(j + 1) then
          puts "[#{i}][#{j}]"
          
          matrix[i][j] = 1
        else
          matrix[i][j] = 0
        end
      end
    end

    matrix
  end
end
