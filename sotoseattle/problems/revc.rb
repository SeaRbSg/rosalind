require_relative './rna'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind

  def self.compl str
    str.chars.map{ |x| NUCLEOTIDS[x] }.join
  end

  def self.reverse_compl dna_str
    Rosalind.compl dna_str.reverse
  end

end

class TestRosalind < Minitest::Test
  def test_rev_compl
    assert_equal 'ACCGGGTTTT', Rosalind.reverse_compl('AAAACCCGGT')
  end
end
