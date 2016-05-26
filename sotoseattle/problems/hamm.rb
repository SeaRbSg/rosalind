require_relative './revc'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind

  ## compare two strands nucleotid by nucleotid and count differences

  def self.hamming_distance s, t
    s.chars.zip(t.chars).count { |a| a.uniq.size == 2 }
  end

end

class TestRosalind < Minitest::Test
  def test_hamming
    assert_equal 7, Rosalind.hamming_distance('GAGCCTACTAACGGGAT', 'CATCGTAATGACGGCCT')
  end
end
