# Problem

# Given: A simple directed acyclic graph with n <= 10^3 vertices in
# the edge list format.

# Return: A topological sorting (i.e., a permutation of vertices) of
# the graph.

# Sample Dataset
# 4 5
# 1 2
# 3 1
# 3 2
# 4 3
# 4 2

# Sample Output
# 4 3 1 2

require "../lib/rosalind_input"
require "../lib/directed_graph"

data = RosalindInput.new("ts.txt").ints

g = DirectedGraph.from_edge_list(data)

puts g.tsort.join(" ")
