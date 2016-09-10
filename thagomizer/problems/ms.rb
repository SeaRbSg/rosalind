# Problem

# The problem of sorting a list of numbers lends itself immediately to
# a divide-and-conquer strategy: split the list into two halves,
# recursively sort each half, and then merge the two sorted sublists
# (recall the problem "Merge Two Sorted Arrays").
# Source: Algorithms by Dasgupta, Papadimitriou, Vazirani. McGraw-Hill. 2006.

# Given:
# A positive integer n <= 10^5 and an array A[1..n] of integers from
# -10^5 to 10^5.

# Return:
# A sorted array A[1..n].

# Sample Dataset
# 10
# 20 19 35 -18 17 -20 20 1 4 4

# Sample Output
# -20 -18 1 4 4 17 19 20 20 35

class Array
  def merge_sort
    sorted_ary = []
  end

  def merge ary1
    ary2 = self.dup

    merged_ary = []
    i1, i2 = 0

    until ary1.empty? and ary2.empty? do

      if ary1[i1] < ary2[i2] then
        merged_ary << ary1.shift
        i1 += 1
      else
        merged_ary << ary2.shift
        i2 += 1

    end

    merged_ary
  end

end
