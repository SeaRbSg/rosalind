require_relative './rna'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind

  ## Reverse strand and substitute with complementary

  def self.reverse_compl dna_str
    dna_str.reverse.chars.map{ |x| NUCLEOTIDS[x] }.join
  end

end

class TestRosalind < Minitest::Test
  def test_rev_compl
    assert_equal 'ACCGGGTTTT', Rosalind.reverse_compl('AAAACCCGGT')
  end
end
