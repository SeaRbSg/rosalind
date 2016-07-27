require '../lib/dna'

dna = DNA.from_file('revc.txt')
puts dna.reverse_complement
