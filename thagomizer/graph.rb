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
