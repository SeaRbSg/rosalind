# Problem

# The task is to use breadth-first search to compute single-source
# shortest distances in an unweighted directed graph.

# Given: A simple directed graph with n <= 10^3 vertices in the edge
# list format.

# Return: An array D[1..n] where D[i] is the length of a shortest path
# from the vertex 1 to the vertex i (D[1]=0). If i is not reachable
# from 1 set D[i] to -1.


# Sample Dataset
# 6 6
# 4 6
# 6 5
# 4 3
# 3 5
# 2 1
# 1 4

# Sample Output
# 0 -1 2 1 3 2

require '../lib/directed_graph'

edges = File.read("bfs.txt").split("\n").map { |l| l.split(/\s/).map(&:to_i) }
max, _ = edges.shift

g         = DirectedGraph.new edges, max
distances = g.all_distances(1)

puts (1..max).map{ |n| distances[n] }.join(' ')
