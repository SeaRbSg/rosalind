require_relative './revc'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind

  ## GC content of dna strand

  def self.gc_content dna_str
    100.0 * dna_str.count('GC') / dna_str.size
  end

  ## Pick the label of the dna strand with highest GC content

  def self.max_gc input_dna
    input_dna.map { |a| [a.first, self.gc_content(a.last)] }
             .max { |a| a.last }
  end

end

class TestRosalind < Minitest::Test
  def test_gc_simplest
    assert_in_delta 37.5, Rosalind.gc_content('AGCTATAG'), 0.0001
  end

  def test_gc_longaniza
    chorizo = 'CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGACTGGGAACCTGCGGGCAGTAGGTGGAAT'
    assert_in_delta 60.919540, Rosalind.gc_content(chorizo), 0.0001
  end

  def test_identify_by_gc
    input = Rosalind.fasta(DATA.read)
    assert_equal 'Rosalind_0808', Rosalind.max_gc(input).first
    assert_in_delta 60.919540, Rosalind.max_gc(input).last
  end
end

__END__
>Rosalind_6404
CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCC
TCCCACTAATAATTCTGAGG
>Rosalind_5959
CCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCT
ATATCCATTTGTCAGCAGACACGC
>Rosalind_0808
CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGAC
TGGGAACCTGCGGGCAGTAGGTGGAAT
