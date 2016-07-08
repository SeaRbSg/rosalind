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

## Use recursion

$cache = {}
$cache["&"] = ""


def find_subsequence str1, str2
  key = "#{str1}&#{str2}"
  return $cache[key] if $cache[key]
  result = ""

  return result if str1.empty? or str2.empty?

  if str1[-1] == str2[-1] then
    result << str1[-1]
    result << find_subsequence(str1[0..-2], str2[0..-2])
  else
    branch1 = find_subsequence(str1[0..-2], str2)
    branch2 = find_subsequence(str1, str2[0..-2])
    if branch1.length > branch2.length
      result << branch1
    else
      result << branch2
    end
  end
  $cache[key] = result
  result
end

puts find_subsequence(dna1, dna2).reverse
