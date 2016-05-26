require_relative './revc'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind

  ## Find where a substring t shows up in s

  def self.substring s, t
    sol = []
    acc = 0
    loop do
      i = s.index(t)
      return sol.join(' ') unless i
      acc += i + 1
      sol << acc
      s = s[i+1..-1]
    end
  end

end

class TestRosalind < Minitest::Test
  def test_substring
    assert_equal '2 4 10', Rosalind.substring('GATATATGCATATACTT', 'ATAT')
    assert_equal '1 3 9',  Rosalind.substring( 'ATATATGCATATACTT', 'ATAT')
    assert_equal '',       Rosalind.substring( 'ATATATGCATATACTT', 'AAAA')
  end
end
