require_relative './revc'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind

  PROTEINS  = { 'UUU' => 'F', 'CUU' => 'L', 'AUU' => 'I', 'GUU' => 'V',
                'UUC' => 'F', 'CUC' => 'L', 'AUC' => 'I', 'GUC' => 'V',
                'UUA' => 'L', 'CUA' => 'L', 'AUA' => 'I', 'GUA' => 'V',
                'UUG' => 'L', 'CUG' => 'L', 'AUG' => 'M', 'GUG' => 'V',
                'UCU' => 'S', 'CCU' => 'P', 'ACU' => 'T', 'GCU' => 'A',
                'UCC' => 'S', 'CCC' => 'P', 'ACC' => 'T', 'GCC' => 'A',
                'UCA' => 'S', 'CCA' => 'P', 'ACA' => 'T', 'GCA' => 'A',
                'UCG' => 'S', 'CCG' => 'P', 'ACG' => 'T', 'GCG' => 'A',
                'UAU' => 'Y', 'CAU' => 'H', 'AAU' => 'N', 'GAU' => 'D',
                'UAC' => 'Y', 'CAC' => 'H', 'AAC' => 'N', 'GAC' => 'D',
                'UAA' => '',  'CAA' => 'Q', 'AAA' => 'K', 'GAA' => 'E',
                'UAG' => '',  'CAG' => 'Q', 'AAG' => 'K', 'GAG' => 'E',
                'UGU' => 'C', 'CGU' => 'R', 'AGU' => 'S', 'GGU' => 'G',
                'UGC' => 'C', 'CGC' => 'R', 'AGC' => 'S', 'GGC' => 'G',
                'UGA' => '',  'CGA' => 'R', 'AGA' => 'R', 'GGA' => 'G',
                'UGG' => 'W', 'CGG' => 'R', 'AGG' => 'R', 'GGG' => 'G'}

  ## Translate to protein string

  def self.protein rna_str
    rna_str.scan(/.{1,3}/).map{ |s| PROTEINS[s] }.join
  end

end

class TestRosalind < Minitest::Test
  def test_protein_translation
    assert_equal 'MAMAPRTEINSTRING', Rosalind.protein('AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA')
  end
end
