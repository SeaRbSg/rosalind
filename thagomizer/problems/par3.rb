# Problem

# This problem is very similar to "2-Way Partition", but now the goal
# is to partition an input array more carefully.


# Given: A positive integer n <= 10^5 and an array A[1..n] of integers
# from -10^5 to 10^5.

# Return: An array B[1..n] such that it is a permutation of A and
# there are indices 1 <= q <= r <= n such that B[i]<A[1] for all
# 1 <= i <= q-1, B[i]=A[1] for all q <= i <= r, and B[i]>A[1] for all
# r+1 <= i <= n.

# Sample Dataset
# 9
# 4 5 6 4 1 2 5 7 4

# Sample Output
# 2 1 4 4 4 5 7 6 5

require "../lib/rosalind_input"

ary = RosalindInput.new("par3.txt").ints[1]

groups = ary.group_by { |x| x <=> ary[0] }

puts "#{groups[-1].join(' ')} #{groups[0].join(' ')} #{groups[1].join(' ')}"
