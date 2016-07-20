# Problem

# An array A[1..n] is said to have a majority element if more than
# half of its entries are the same.

# Given: A positive integer k <= 20, a positive integer n <= 10^4, and
# k arrays of size n containing positive integers not exceeding 10^5.

# Return: For each array, output an element of this array occurring
# strictly more than n/2 times if such element exists, and "-1"
# otherwise.

# Sample Dataset
# 4 8
# 5 5 5 5 5 5 5 5
# 8 7 7 7 1 7 3 7
# 7 1 6 5 10 100 1000 1
# 5 1 6 7 1 1 10 1

# Sample Output
# 5 7 -1 -1

require 'pp'

data = File.read("maj.txt").split("\n").map { |l| l.split(/\s/) }

data.shift

data.each do |ary|
  k, v = ary.group_by { |x| x }.max_by { |h, v| v.length }

  if v.length > (ary.length / 2) then
    print "#{k} "
  else
    print "-1 "
  end
end

puts