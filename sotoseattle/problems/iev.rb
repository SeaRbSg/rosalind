require_relative './iprb'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind
  BASE = %w[AA-AA AA-Aa AA-aa Aa-Aa Aa-aa aa-aa] # the 6 base couples
  DOMN = 'A'                                     # dominant 4 phenotype
  CARD = 2.0                                     # allele cardinality
  OFFS = 2.0                                     # size of litter

  def self.iev arr
    input = BASE.map{|a| a.split('-').map(&:chars)}.zip(arr)

    counting = input.map do |alleles, n|
      alleles[0].product(alleles[1]).count{ |k| k.include? DOMN } * n
    end

    counting.reduce(:+) * OFFS / (CARD ** 2)
  end
end


class TestExpOff < Minitest::Test
  def test_calculate_expected_offspring
    assert_equal 3.5, Rosalind.iev([1,0,0,1,0,1])
    assert_equal 7.0, Rosalind.iev([2,0,0,2,0,2])
    assert_equal 161131.5, Rosalind.iev([18495, 19225, 19691, 18455, 18627, 18776])
  end
end

