input = File.read "rosalind_cc.txt"

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

not_visited = (1..graph.length).to_a
num_components = 0

until not_visited.empty?
  num_components += 1

  node = not_visited.shift
  distance = 0
  to_visit = graph[node-1]
  visited = []

  loop do
    unless visited.include? node
      next_nodes = graph[node-1]
      to_visit += next_nodes
    end

    visited << node

    node, distance = to_visit.pop

    if to_visit.empty?
      break
    end
  end

  not_visited -= visited
end

puts num_components
