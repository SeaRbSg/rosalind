# Problem
# A string u is a common subsequence of strings s and t if the symbols
# of u appear in order as a subsequence of both s and t. For example,
# "ACTG" is a common subsequence of "AACCTTGG" and "ACACTGTGA".

# Analogously to the definition of longest common substring, u is a
# longest common subsequence of s and t if there does not exist a
# longer common subsequence of the two strings. Continuing our above
# example, "ACCTTG" is a longest common subsequence of "AACCTTGG" and
# "ACACTGTGA", as is "AACTGG".

# Given:
# Two DNA strings s and t (each having length at most 1 kbp) in FASTA format.

# Return:
# A longest common subsequence of s and t. (If more than one solution
# exists, you may return any one.)

# Sample Dataset
# >Rosalind_23
# AACCTTGG
# >Rosalind_64
# ACACTGTGA

# Sample Output
# AACTGG

require 'pp'
require 'pry'
require '../fasta'

dna1, dna2 = Fasta.new("lcsq.txt").read_dnas.values.map(&:str).sort_by(&:length)

## Keep track of the last character used in the subsequence in each
## dna string. Move through each string character by character and
## look to see if the ith character of DNA1 appears in any of the
## unused characters in dna2. Also figure out if the ith character of
## DNA2 appears in any of the unused characters of dna1. Pick
## whichever one results in the fewest used characters.


max = [dna1.length, dna2.length].max
i1  = 0
i2  = 0
seq = ""

0.upto(max) do |i|

  begin
    fuck = dna1[i1..i].index(dna2[i]) + i1
    shit = dna2[i2..i].index(dna1[i]) + i2
  rescue
    next
  end

  if fuck < shit then
    seq << dna2[i]
    i1 = fuck + 1
    i2 = i + 1
  else
    seq << dna1[i]
    i1 = i + 1
    i2 = shit + 1
  end

  i += 1
end

puts seq
