input = File.read "rosalind_deg.txt"
# input = <<-HERE
# 6 7
# 1 2
# 2 3
# 6 3
# 5 6
# 2 5
# 2 4
# 4 1
# HERE

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

puts graph.map(&:count).join(" ")
