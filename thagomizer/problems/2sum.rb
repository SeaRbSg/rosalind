# Problem

# Given:
# A positive integer k <= 20, a positive integer n <= 10^4, and k
# arrays of size n containing integers from -10^5 to 10^5.

# Return:
# For each array A[1..n], output two different indices 1 <= p < q <= n
# such that A[p]= -A[q] if exist, and "-1" otherwise.

# Sample Dataset
# 4 5
# 2 -3 4 10 5
# 8 2 4 -2 -8
# -5 2 3 2 -4
# 5 4 -5 6 8

# Sample Output
# -1
# 2 4
# -1
# 1 3

data = File.read("2sum.txt").split(/\n/)

k, n = data.shift.split(/\s/).map(&:to_i)


k.times do
  ary = data.shift.split(/\s/).map(&:to_i)

  pairs = ary.group_by { |x| x.abs }.values.map(&:uniq).compact.select { |y| y.size == 2 }

  unless pairs.empty?
    pairs = pairs.map { |p| p.map { |item| ary.index(item) } }
    puts pairs.min_by { |a, b| b }.map { |x| x + 1 }.join(' ')
  else
    puts -1
  end
end
