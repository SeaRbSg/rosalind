require 'minitest/autorun'
require 'minitest/pride'

class Rosalind

  NUCLEOTIDS = {'A' => 'T', 'C' => 'G', 'G' => 'C', 'T' => 'A'}

  ## Count all nucleotids in order

  def self.nucleo_count dna_str
    NUCLEOTIDS.keys.sort.map{ |c| dna_str.count c }.join " "
  end

  ## Parse dna strings in FASTA format

  def self.fasta input_dna
    input_dna.delete("\n").delete(" ").scan(/>(Rosalind_\d+)([AGCT]+)/)
  end

end

class TestRosalind < Minitest::Test
  def test_count_nucleothingies
    chorizo = 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'
    assert_equal '20 12 17 21', Rosalind.nucleo_count(chorizo)
  end
end
