# Problem

# Given a collection of strings, their trie (often pronounced "try" to
# avoid ambiguity with the general term tree) is a rooted tree formed
# as follows. For every unique first symbol in the strings, an edge is
# formed connecting the root to a new vertex. This symbol is then used
# to label the edge.

# We may then iterate the process by moving down one level as
# follows. Say that an edge connecting the root to a node v is labeled
# with 'A'; then we delete the first symbol from every string in the
# collection beginning with 'A' and then treat v as our root. We apply
# this process to all nodes that are adjacent to the root, and then we
# move down another level and continue.

# As a result of this method of construction, the symbols along the
# edges of any path in the trie from the root to a leaf will spell out
# a unique string from the collection, as long as no string is a
# prefix of another in the collection (this would cause the first
# string to be encoded as a path terminating at an internal node).

# Given:
# A list of at most 100 DNA strings of length at most 100 bp, none of
# which is a prefix of another.

# Return:
# The adjacency list corresponding to the trie T for these patterns,
# in the following format. If T has n nodes, first label the root with
# 1 and then label the remaining nodes with the integers 2 through n
# in any order you like. Each edge of the adjacency list of T will be
# encoded by a triple containing the integer representing the edge's
# parent node, followed by the integer representing the edge's child
# node, and finally the symbol labeling the edge.


# Sample Dataset
# ATAGA
# ATC
# GAT

# Sample Output
# 1 2 A
# 2 3 T
# 3 4 A
# 4 5 G
# 5 6 A
# 3 7 C
# 1 8 G
# 8 9 A
# 9 10 T

require "../lib/rosalind_input"

class Node
  attr_accessor :children
  attr_accessor :number
  attr_accessor :trie

  def initialize trie, num
    @number = num
    @trie = trie
    @children = {}
  end

  def insert str
    c = str[0]

    unless self.children[c] then
      @children[c] = Node.new @trie, @trie.next_number
      @trie.next_number += 1
    end

    @children[c].insert str[1..-1] if str.length > 1
  end

  def to_s
    s = ""
    children.each do |k, v|
      s += "#{self.number} #{v.number} #{k}\n"
      s += v.to_s
    end
    s
  end
end

class Trie
  attr_accessor :root
  attr_accessor :next_number

  def initialize
    @next_number = 1
    @root = Node.new self, @next_number
    @next_number += 1
  end

  def insert str
    @root.insert str
  end

  def to_s
    @root.to_s
  end
end

trie = Trie.new

strs = RosalindInput.new("trie.txt").lines

strs.each do |str|
  trie.insert str
end

puts trie
