# Problem

# The problem is to find a given set of keys in a given array.

# Given: Two positive integers n <= 10^5 and m <= 10^5, a sorted array
# A[1..n] of integers from -10^5 to 10^5 and a list of m integers
# -10^5 <= k1,k2,...,km <= 10^5.

# Return: For each ki, output an index 1<=j<=n s.t. A[j]=ki or "-1" if
# there is no such index.

# Sample Dataset

# 5
# 6
# 10 20 30 40 50
# 40 10 35 15 40 20
# Sample Output

# 4 1 -1 -1 4 2

require 'pp'

_, _, ary, to_find = File.read("bins.txt").split("\n")

ary     = ary.split(/\s/).map(&:to_i)
to_find = to_find.split(/\s/).map(&:to_i)

def binary_search ary, to_find, offset = 0
  return -1 if ary.empty?
  if ary.length == 1 then
    return ary[0] == to_find ? (1 + offset) : -1
  end

  mid = ary.length / 2

  return case
         when ary[mid] == to_find
           mid + offset + 1
         when ary[mid] < to_find
           binary_search(ary[(mid + 1)..-1], to_find, offset + mid + 1)
         when ary[mid] > to_find
           binary_search(ary[0...mid], to_find, offset)
         end
end

puts to_find.map { |j| binary_search(ary, j) }.join(" ")
