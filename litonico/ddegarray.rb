input = File.read "rosalind_ddeg.txt"

rows = input.split("\n")
num_nodes = rows.first.split(" ").first.to_i
edgelist = rows.drop(1)

graph = Array.new(num_nodes) { Array.new }

edgelist.each do |edge_string|
  edge = edge_string.split(" ").map(&:to_i)
  v1, v2 = edge
  graph[v1-1] += [v2]
  graph[v2-1] += [v1]
end

ddeg = graph.map do |node_neighbors|
  node_neighbors.inject(0) do |total, neighbor|
    total + graph[neighbor-1].count
  end
end

puts ddeg.join(" ")
