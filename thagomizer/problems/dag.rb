# Problem

# Given: A positive integer k <= 20 and k simple directed graphs in
# the edge list format with at most 10^3 vertices and 3 - 10^3 edges each.

# Return: For each graph, output "1" if the graph is acyclic and "-1"
# otherwise.

# Sample Dataset

# 3

# 2 1
# 1 2

# 4 4
# 4 1
# 1 2
# 2 3
# 3 1

# 4 3
# 4 3
# 3 2
# 2 1

# Sample Output
# 1 -1 1

require "../lib/directed_graph"
require "../lib/rosalind_input"
require "pp"

data = RosalindInput.new("dag.txt").ints

k = data.shift[0]

results = []

puts (0...k).map {
  data.shift # bleed the empty line

  node_count, edge_count = data.shift

  edges = []
  edge_count.times do
    edges << data.shift
  end

  g = DirectedGraph.new edges, node_count

  g.acyclic? ? 1 : -1
}.join(' ')
