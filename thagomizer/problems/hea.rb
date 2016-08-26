# Problem

# A binary heap is a binary tree based data structure that is often
# used to implement priority queues. Binary heaps, in turn, can be
# easily implemented using an array if the underlying tree is a
# complete binary tree. The tree nodes have a natural ordering: row by
# row, starting at the root and moving left to right within each
# row. If there are n nodes, this ordering specifies their positions
# 1,2,...,n within the array. Moving up and down the tree is easily
# simulated on the array, using the fact that node number j has parent
# [j/2] and children 2j and 2j+1.

# The goal of this problem is to build a heap from the given
# array. For this, go from the end to the beginning of a given array
# and let each element "bubble up".
# Source: Algorithms by Dasgupta, Papadimitriou, Vazirani. McGraw-Hill. 2006.

# Given:
# A positive integer n <= 10^5 and array A[1..n] of integers from -10^5 to 10^5.

# Return:
# A permuted array A satisfying the binary max heap property: for any
# 2 <= i <= n, A[[i/2]] >= A[i].

# Sample Dataset
# 5
# 1 3 5 7 2

# Sample Output
# 7 5 1 3 2

class Heap
  def initialize
    @data       = []
    @next_index = 1
  end

  def insert x
    @data[@next_index] = x
    i = @next_index

    while i > 1 do
      break if @data[i/2] > x

      temp      = @data[i/2]
      @data[i/2] = x
      @data[i]   = temp
      i = i/ 2
    end
    @next_index += 1
  end

  def to_s
    @data.join(' ')
  end
end

ary = File.read("hea.txt").split("\n")[1].split(/\s/).map(&:to_i)

heap = Heap.new
ary.each { |x| heap.insert x }
puts heap
