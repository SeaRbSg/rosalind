# Problem

# Given:
# A simple graph with n <= 10^3 vertices in the edge list format.

# Return:
# An array D[1..n] where D[i] is the sum of the degrees of i's neighbors.

# Sample Dataset
# 5 4
# 1 2
# 2 3
# 4 3
# 2 4

# Sample Output
# 3 5 5 5 0


require 'pp'
require "../lib/rosalind_input"

edges = RosalindInput.new("ddeg.txt").ints
max, _ = edges.shift

neighbors = Hash.new { |h,k| h[k] = [] }

edges.each do |from, to|
  neighbors[from] << to
  neighbors[to]   << from
end

puts (1..max).map { |k| neighbors[k].inject(0) { |m, i| m + neighbors[i].length } }.join(' ')
