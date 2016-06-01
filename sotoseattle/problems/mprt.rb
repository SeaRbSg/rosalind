require 'open-uri'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind

  N_GLYCOSYLATION = /(?=(N[^P][S|T][^P]))/
  PROTEIN_BASIC   = /^([A-Z0-9]+)_*/

  def self.fasto input_prot
    input_prot.split("\n").reject { |a| a.match(/^\>/) }.join
  end

  def self.urify proto
    basic = proto.match(PROTEIN_BASIC)[1]
    URI("http://www.uniprot.org/uniprot/#{basic}.fasta")
  end

  def self.pro_motiff proteins
    sol = []

    proteins.split.each do |proto|
      strand    = fasto open(urify(proto)).read
      positions = strand.scan(N_GLYCOSYLATION).flatten
                  .map { |s| strand.index(s) + 1 }
                  .join ' '

      (sol << proto << positions) unless positions == ''
    end

    sol.join("\n")
  end
end

class TestRosalind < Minitest::Test
  def test_pro_motiff_basic
    out = "B5ZC00\n85 118 142 306 395\nP07204_TRBM_HUMAN\n47 115 116 382 409\nP20840_SAG1_YEAST\n79 109 135 248 306 348 364 402 485 501 614"
    assert_equal out, Rosalind.pro_motiff(DATA.read)
  end

  def test_pro_motiff_exercise
    inputo = File.open('../test_data/rosalind_mprt.txt').read
    output = File.open('../test_data/sol_mprt.txt').read

    assert_equal output, Rosalind.pro_motiff(inputo)
  end
end

__END__
A2Z669
B5ZC00
P07204_TRBM_HUMAN
P20840_SAG1_YEAST
