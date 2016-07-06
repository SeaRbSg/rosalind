# Problem

# The graph theoretical analogue of the quandary stated in the
# introduction above is that if we have an RNA string s that does not
# have the same number of occurrences of 'C' as 'G' and the same
# number of occurrences of 'A' as 'U', then the bonding graph of s
# cannot possibly possess a perfect matching among its basepair
# edges. For example, see Figure 1; in fact, most bonding graphs will
# not contain a perfect matching.

# In light of this fact, we define a maximum matching in a graph as a
# matching containing as many edges as possible. See Figure 2 for
# three maximum matchings in graphs.

# A maximum matching of basepair edges will correspond to a way of
# forming as many base pairs as possible in an RNA string, as shown in
# Figure 3.

# Given:
# An RNA string s of length at most 100.

# Return:
# The total possible number of maximum matchings of basepair edges in
# the bonding graph of s.

# Sample Dataset

## >Rosalind_92
## AUGCUUC

# Sample Output

## 6

require '../fasta'
require 'pp'

class Prob
  def self.permute n, k
    n.factorial / (n - k).factorial
  end
end

class Fixnum
  def factorial
    return 1 if self < 2
    (2..self).inject(&:*)
  end
end

nodes = Fasta.new("mmch.txt").read_dnas.values.first.str.split(//)

groups = Hash[nodes.group_by { |i| i }.map { |k, v| [k, v.length] }]

## The maximum matching will contain min(groups["A"], groups["U"]) AU
## edges and min(groups["C"], groups["T"]) edges.
## So how many ways can I connect the small group of nodes to the
## large group which is permute.

au_bonds = Prob.permute(*([groups["A"], groups["U"]].minmax.reverse))
gc_bonds = Prob.permute(*([groups["C"], groups["G"]].minmax.reverse))

## Multiply the two bond counts together.

pp au_bonds * gc_bonds
