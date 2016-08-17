# Problem

# The problem of sorting a list of numbers lends itself immediately to
# a divide-and-conquer strategy: split the list into two halves,
# recursively sort each half, and then merge the two sorted sublists
# (recall the problem "Merge Two Sorted Arrays").
# Source: Algorithms by Dasgupta, Papadimitriou, Vazirani. McGraw-Hill. 2006.

# Given:
# A positive integer n <= 10^5 and an array A[1..n] of integers from
# -10^5 to 10^5.

# Return:
# A sorted array A[1..n].

# Sample Dataset
# 10
# 20 19 35 -18 17 -20 20 1 4 4

# Sample Output
# -20 -18 1 4 4 17 19 20 20 35

class Array
  def merge ary1
    ary2 = self.clone

    merged_ary = []
    loop do
      if ary1.empty? then
        merged_ary += ary2
        break
      elsif ary2.empty? then
        merged_ary += ary1
        break
      end

      if ary1[0] < ary2[0] then
        merged_ary << ary1.shift
      else
        merged_ary << ary2.shift
      end
    end
    return merged_ary
  end
end

ary = File.read("ms.txt").split("\n")[1].split(/\s/).map(&:to_i).map { |x| [x] }

while ary.length > 1 do
  temp = []
  ary.each_slice(2) do |a, b|
    if b then
      temp << a.merge(b)
    else
      temp << a unless b
    end
  end
  ary = temp
end

puts ary.first.join(' ')


# # Divide the unsorted list into n sublists, each containing 1 element (a list of 1 element is considered sorted).

# # Repeatedly merge sublists to produce new sorted sublists until there is only 1 sublist remaining. This will be the sorted list.
