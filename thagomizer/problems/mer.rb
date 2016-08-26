# Problem

# The merging procedure is an essential part of "Merge Sort" (which is
# considered in one of the next problems).

# Given: A positive integer n <= 10^5 and a sorted array A[1..n] of
# integers from -10^5 to 10^5, a positive integer m <= 10^5 and a
# sorted array B[1..m] of integers from -10^5 to 10^5.

# Return:
# A sorted array C[1..n+m] containing all the elements of A and B.

# Sample Dataset
# 4
# 2 4 10 18
# 3
# -5 11 12

# Sample Output
# -5 2 4 10 11 12 18

raw_data = File.read("mer.txt").split("\n").map{ |l| l.split(/\s/).map(&:to_i) }

data = []

data[0]    = raw_data[1]
data[1]    = raw_data[3]
merged_ary = []

loop do
  if data[0].empty? then
    merged_ary += data[1]
    break
  elsif data[1].empty? then
    merged_ary += data[0]
    break
  end

  if data[0][0] < data[1][0] then
    merged_ary << data[0].shift
  else
    merged_ary << data[1].shift
  end
end

puts merged_ary.join(' ')
