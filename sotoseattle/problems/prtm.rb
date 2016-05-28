require_relative './prot'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind

  AMINO_MASS = { 'A' =>  71.03711,
                 'C' =>  103.00919,
                 'D' =>  115.02694,
                 'E' =>  129.04259,
                 'F' =>  147.06841,
                 'G' =>  57.02146,
                 'H' =>  137.05891,
                 'I' =>  113.08406,
                 'K' =>  128.09496,
                 'L' =>  113.08406,
                 'M' =>  131.04049,
                 'N' =>  114.04293,
                 'P' =>  97.05276,
                 'Q' =>  128.05858,
                 'R' =>  156.10111,
                 'S' =>  87.03203,
                 'T' =>  101.04768,
                 'V' =>  99.06841,
                 'W' =>  186.07931,
                 'Y' =>  163.06333 }

  def self.protein_mass protein_strand
    protein_strand.chomp.chars.map{ |amino| AMINO_MASS[amino] }.reduce :+
  end

end

class TestRosalind < Minitest::Test

  def test_basic_protein_mass
    assert_in_delta 821.392, Rosalind.protein_mass('SKADYEK'), 0.0001
  end

  def test_long_protein_mass
    i = File.new("../test_data/rosalind_mrna.txt").read
    assert_in_delta 118465.66184, Rosalind.protein_mass(i), 0.0001
  end

  def test_exercise_protein_mass
    i = File.new("../test_data/rosalind_prtm.txt").read
    assert_in_delta 105527.78843, Rosalind.protein_mass(i), 0.0001
  end
end



