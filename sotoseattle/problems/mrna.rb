require_relative './prot'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind
  EOS = "-"                      # End of Strand

  def self.congruent? a, b, n
    a % n == b % n
  end

  def self.amin_2_rna
    h = {}
    RNA2AMIN.each do |k, v|
      if h[v]
        h[v] << k
      else
        h[v] = [k]
      end
    end
    h
  end

  def self.n_possible_RNAs protein_str
    input = protein_str.chomp + EOS

    translator = amin_2_rna
    input.chars.map{|c| translator[c].size }.reduce(:*) % 1_000_000
  end

end

class TestRosalind < Minitest::Test
  def test_modulo_congruency
    a, b, c, d = 29, 73, 10, 32
    n = 11
    assert Rosalind.congruent?(a, b, n)
    assert Rosalind.congruent?(c, d, n)
    assert Rosalind.congruent?(a+c, b+d, n)
  end

  def test_longest_common_substring_basic
    assert_equal 12, Rosalind.n_possible_RNAs('MA')
  end

  def test_longest_common_substring_exercise
    i = File.new("../test_data/rosalind_mrna.txt").read
    assert_equal 770624, Rosalind.n_possible_RNAs(i)
  end
end

