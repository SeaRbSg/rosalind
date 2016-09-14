# Problem
# The task is to implement a linear time randomized algorithm for the
# selection problem.

# Given: A positive integer n <= 10^5 and an array A[1..n] of integers
# from -10^5 to 105, a positive number k <= n.

# Return:
# The k-th smallest element of A.

# Sample Dataset
# 11
# 2 36 5 21 8 13 11 20 5 4 1
# 8

# Sample Output
# 13

require "../lib/rosalind_input"

data = RosalindInput.new("med.txt").ints

_   = data.shift
ary = data.shift
k   = data.shift[0]

loop do
  r = ary[Random.rand(0...ary.length)]

  groups = ary.group_by { |i| i <=> r}
  s_l = groups[-1] || []
  s_m = groups[0]  || []
  s_h = groups[1]  || []

  case
  when k <= s_l.length
    ary = s_l
    next
  when k <= s_l.length + s_m.length
    puts s_m[0]
    break
  else
    k -= s_l.length + s_m.length
    ary = s_h
    next
  end
end
