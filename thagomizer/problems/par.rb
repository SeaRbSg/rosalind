# Given:
# A positive integer n <= 10^5 and an array A[1..n] of integers from
# -10^5 to 10^5.

# Return:
# A permuted array B[1..n] such that it is a permutation of A and
# there is an index 1 <= q <= n such that B[i] <= A[1] for all 1 <= i
# <= q-1, B[q]=A[1], and B[i]>A[1] for all q+1 <= i <= n.

# Sample Dataset
# 9
# 7 2 5 6 1 3 9 4 8

# Sample Output
# 5 6 3 4 1 2 7 9 8

ary = File.read("par.txt").split("\n")[1].split(/\s/).map(&:to_i)

pivot = ary.shift
left, right = ary.partition { |x| x < pivot }

puts (left + [pivot] + right).join(' ')
