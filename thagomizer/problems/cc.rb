# Problem

# The task is to use depth-first search to compute the number of
# connected components in a given undirected graph.

# Given: A simple graph with n <= 10^3 vertices in the edge list format.

# Return: The number of connected components in the graph.

# Sample Dataset
# 12 13
# 1 2
# 1 5
# 5 9
# 5 10
# 9 10
# 3 4
# 3 7
# 3 8
# 4 8
# 7 11
# 8 11
# 11 12
# 8 12

# Sample Output
# 3

require "../lib/graph"

edges = File.read("cc.txt").split("\n").map { |l| l.split(/\s/).map(&:to_i) }
max, _ = edges.shift

g = Graph.new edges, max
puts g.components.length
