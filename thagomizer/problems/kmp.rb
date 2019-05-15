# A prefix of a length n string s  is a substring s[1:j]; a suffix of
# s is a substring s[k:n]

# The failure array of s is an array P of length n for which P[k] is
# the length of the longest substring s[j:k] that is equal to some
# prefix s[1:k-j+1], where j cannot equal 1 (otherwise, P[k] would
# always equal k). By convention, P[1]=0

# Given: A DNA string (of length at most 100 kbp) in FASTA format.

# Return: The failure array of s

require 'pp'
require_relative '../lib/fasta'

dnas = Fasta.new("kmp.txt").read_dnas
dna = dnas.values.first

failure_ary = [0]

longest_pre_suf_fix = 0

i = 1
while i < dna.length

  if dna[i] == dna[longest_pre_suf_fix] then
    longest_pre_suf_fix += 1
    failure_ary << longest_pre_suf_fix
    i += 1
  else
    if longest_pre_suf_fix == 0 then
      i += 1
      failure_ary << 0
    else
      longest_pre_suf_fix = failure_ary[longest_pre_suf_fix - 1]
    end
  end
end

puts failure_ary.join(' ')
