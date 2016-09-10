require "../lib/dna"
require "../lib/rosalind_input"


lines = RosalindInput.new("hamm.txt").lines
dna0 = DNA.from_str(lines[0])
dna1 = DNA.from_str(lines[1])

puts dna0.hamming_distance(dna1)
