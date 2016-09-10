# In an undirected graph, the degree d(u) of a vertex u is the number
# of neighbors u has, or equivalently, the number of edges incident
# upon it.

# Given: A simple graph with n<=10^3 vertices in the edge list format.

# Return: An array D[1..n] where D[i] is the degree of vertex i.

# Sample Dataset

# 6 7
# 1 2
# 2 3
# 6 3
# 5 6
# 2 5
# 2 4
# 4 1

# Sample Output

# 2 4 2 2 2 2
require "../lib/rosalind_input"

edges = RosalindInput.new("deg.txt").ints

max, _  = edges.shift

edges = edges.flatten.group_by { |x| x }

puts (1..max).map { |k| edges[k].length or 0 }.join(" ")
