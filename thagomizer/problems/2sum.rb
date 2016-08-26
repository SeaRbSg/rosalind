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

  results = ""
  i = 0
  while i < ary.length do
    j = i + 1

    while j < ary.length do
      if ary[i] == (-1 * ary[j]) then
        results = "#{i + 1} #{j + 1}"
        break
      end
      j += 1
    end

    unless results.empty? then
      puts results
      break
    end

    i += 1

    puts -1 if i == ary.length
  end
end
