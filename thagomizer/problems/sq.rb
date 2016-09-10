# Problem

# Given: A positive integer k <= 20 and k simple undirected graphs
# with n <= 400 vertices in the edge list format.

# Return: For each graph, output "1" if it contains a simple cycle
# (that is, a cycle which doesn't intersect itself) of length 4  and
# "-1" otherwise.

# Sample Dataset

# 2

# 4 5
# 3 4
# 4 2
# 3 2
# 3 1
# 1 2

# 4 4
# 1 2
# 3 4
# 2 4
# 4 1

# Sample Output
# 1 -1

### Correct output for my current file
### 1 -1 1 -1 -1 -1 1 -1 1 -1 -1 -1 -1 -1 -1 -1

require '../lib/graph'
require "../lib/rosalind_input"

data = RosalindInput.new("sq.txt").ints

k = data.shift[0]

results = []

k.times do |x|
  data.shift # bleed the empty line

  node_count, edge_count = data.shift

  edges = []
  edge_count.times do
    edges << data.shift
  end

  g = Graph.new edges, node_count

  g.nodes.each do |n|
    stack = [[n, []]]

    until results[x] or stack.empty?
      current, path = stack.pop

      p = path + [current]

      if p.length == 4
        if g.graph[current].include? n
          results[x] = 1
        else
          next
        end
      end

      g.graph[current].each do |neighbor|
        next if p.include?(neighbor)
        stack << [neighbor, p]
      end
    end
  end

  results[x] = -1 unless results[x]
end

puts results.join(' ')
