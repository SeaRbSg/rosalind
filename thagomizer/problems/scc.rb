# Problem

# Given: A simple directed graph with n <= 10^3 vertices in the edge
# list format.

# Return: The number of strongly connected components in the graph.

# Sample Dataset
# 6 7
# 4 1
# 1 2
# 2 4
# 5 6
# 3 2
# 5 3
# 3 5

# Sample Output
# 3

require "../lib/directed_graph"
require "../lib/rosalind_input"
require "pp"

edges  = RosalindInput.new("scc.txt").ints
max, _ = edges.shift

g = DirectedGraph.new edges, max

puts g.strongly_connected_components.length
