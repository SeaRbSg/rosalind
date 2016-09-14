# coding: utf-8
# Problem

# Comparing the algorithms for sorting and "Median" finding we notice
# that, beyond the common divide-and-conquer philosophy and structure,
# they are exact opposites. "Merge Sort" splits the array in two in
# the most convenient way (first half, second half), without any
# regard to the magnitudes of the elements in each half; but then it
# works hard to put the sorted subarrays together. In contrast, the
# median algorithm is careful about its splitting (smaller numbers
# first, then the larger ones), but its work ends with the recursive
# call.

# Quick sort is a sorting algorithm that splits the array in exactly
# the same way as the median algorithm; and once the subarrays are
# sorted, by two recursive calls, there is nothing more to do. Its
# worst-case performance is theta(n2), like that of median-finding. But it
# can be proved that its average case is O(nlogn); furthermore,
# empirically it outperforms other sorting algorithms. This has made
# quicksort a favorite in many applications for instance, it is the
# basis of the code by which really enormous files are sorted.


# Given:
# A positive integer n <= 10^5 and an array A[1..n] of integers from
# -10^5 to 10^5.

# Return:
# A sorted array A[1..n].


# Sample Dataset
# 7
# 5 -2 4 7 8 -10 11

# Sample Output
# -10 -2 4 5 7 8 11


# algorithm quicksort(A, lo, hi) is
#     if lo < hi then
#         p := partition(A, lo, hi)
#         quicksort(A, lo, p – 1)
#         quicksort(A, p + 1, hi)

# algorithm partition(A, lo, hi) is
#     pivot := A[hi]
#     i := lo        // place for swapping
#     for j := lo to hi – 1 do
#         if A[j] ≤ pivot then
#             swap A[i] with A[j]
#             i := i + 1
#     swap A[i] with A[hi]
#     return i

require "../lib/rosalind_input"
require "pp"

data = RosalindInput.new("qs.txt").ints

_   = data.shift
ary = data.shift


def quicksort ary, l, h
  if l < h then
    p = parition(ary, l, h)
    quicksort(ary, l, p - 1)
    quicksort(ary, p + 1, h)
  end
end

def parition ary, l, h
  pivot = ary[h]

  i = l

  (l...h).each do |j|
    if ary[j] < pivot then
      ary[i], ary[j] = ary[j], ary[i]
      i += 1
    end
  end
  ary[i], ary[h] = ary[h], ary[i]

  return i
end

quicksort(ary, 0, ary.length - 1)

puts ary.join(' ')
