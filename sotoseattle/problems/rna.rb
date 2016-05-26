require_relative './dna'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind

  ## Change T to U nucleotid

  def self.transcribe dna_str
    dna_str.gsub('T', 'U')
  end

end

class TestRosalind < Minitest::Test
   def test_transcr
    assert_equal 'GAUGGAACUUGACUACGUAAAUU', Rosalind.transcribe('GATGGAACTTGACTACGTAAATT')
  end
end
