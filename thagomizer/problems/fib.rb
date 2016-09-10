require "../lib/rosalind_input"

n_mos, litter_size = RosalindInput.new("fib.txt").ints[0]

results = [0, 1, 1]

(2..n_mos).each do |i|
  results[i] = results[i - 2] * litter_size + results[i - 1]
end

puts results[n_mos]
