input = File.read "rosalind_bfs.txt"

rows = input.split("\n")
num_nodes = rows.first.split(" ").first.to_i
edgelist = rows.drop(1)

graph = Array.new(num_nodes) { Array.new }

edgelist.each do |edge_string|
  edge = edge_string.split(" ").map(&:to_i)
  v1, v2 = edge
  graph[v1-1] += [v2]
end

all_distances = graph.map.with_index do |node_neighbors, end_node_index|
  out = -1

  node = 1
  distance = 0
  to_visit = graph[node-1].map { |n| [n, distance + 1] }
  visited = []

  loop do
    if node == end_node_index+1
      out = distance
      break
    end

    unless visited.include? node
      next_nodes = graph[node-1].map { |n| [n, distance + 1] }
      to_visit += next_nodes
    end

    visited << node

    node, distance = to_visit.shift

    if to_visit.empty?
      out = -1
      break
    end
  end

  out
end

puts all_distances.join(" ")
