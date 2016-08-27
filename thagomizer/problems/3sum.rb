# Problem

# Given: A positive integer k <= 20, a postive integer n <= 10^4, and
# k arrays of size n containing integers from -10^5 to 10^5.

# Return: For each array A[1..n], output three different indices 1 <=
# p < q < r <= n such that A[p]+A[q]+A[r]=0 if exist, and "-1" otherwise.

# Sample Dataset
# 4 5
# 2 -3 4 10 5
# 8 -6 4 -2 -8
# -5 2 3 2 -4
# 2 4 -5 6 8

# Sample Output
# -1
# 1 2 4
# 1 2 3
# -1

require 'pp'

data = File.read("3sum.txt").split(/\n/)

k, n = data.shift.split(/\s/).map(&:to_i)

results = []

k.times do |x|
  orig_ary = data.shift.split(/\s/).map(&:to_i)
  h = {}
  orig_ary.each_with_index { |x, index| h[x] ||= index + 1 }

  ary = orig_ary.uniq


  (0...ary.length).each do |p|
    (1...ary.length).each do |q|
      s = ary[p] + ary[q]
      if r = h[s * -1] then
        puts "#{h[ary[p]]} #{h[ary[q]]} #{r}"
        results[x] = "#{h[ary[p]]} #{h[ary[q]]} #{r}"
        break
      end
    end
    break if results[x]
  end

  puts -1 unless results[x]
end
