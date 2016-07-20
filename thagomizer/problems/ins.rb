# coding: utf-8
# Problem

# Insertion sort is a simple algorithm with quadratic running time
# that builds the final sorted array one item at a time.

# Given:
# A positive integer n <= 10^3 and an array A[1..n] of integers.

# Return:
# The number of swaps performed by insertion sort algorithm on A[1..n].

# Sample Dataset
# 6
# 6 10 4 5 1 2

# Sample Output
# 12

# for i = 2:n,
#     for (k = i; k > 1 and a[k] < a[k-1]; k--)
#         swap a[k,k-1]
#     → invariant: a[1..i] is sorted
# end

require 'pp'

def instrumented_insertion_sort ary, swap_count = 0
  (1...ary.length).each do |i|
    k = i
    while k > 0 and ary[k] < ary[k - 1] do
      t = ary[k]
      ary[k] = ary[k - 1]
      ary[k - 1] = t
      swap_count += 1

      k -= 1
    end
  end

  swap_count
end

_, ary = File.read("ins.txt").split("\n").map { |l| l.split(/\s/).map(&:to_i) }

puts instrumented_insertion_sort ary
