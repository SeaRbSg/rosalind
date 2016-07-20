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

edges = File.read("deg.txt").split("\n").map { |l| l.split(/\s/).map(&:to_i) }

max, _  = edges.shift

edges = edges.flatten.group_by { |x| x }

1.upto(max) do |k|
  print "#{edges[k].length or 0} "
end
puts