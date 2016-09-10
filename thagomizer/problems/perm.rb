require '../lib/rosalind_input'

n = RosalindInput.new("perm.txt").int

ary = (1..n).to_a
puts ary.inject(1, :*)
ary.permutation.each do |perm|
  puts perm.join(' ')
end
