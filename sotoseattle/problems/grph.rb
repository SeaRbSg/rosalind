require_relative './subs'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind
  def self.graph chorizo, k=3
    input  = Hash[*Rosalind.fasta(chorizo).flatten]
    output = ""

    input.each do |label, strand|
      input.select { |l, s| strand[0, k] == s[-k..-1] && strand != s }
           .each {|l, s| output << "#{l} #{label}\n" }
    end

    output.chomp
  end
end


class TestRosalind < Minitest::Test
  def test_graph_simple
    input  = ">Rosalind_0498\nAAATAAA\n>Rosalind_2391\nAAATTTT\n>Rosalind_2323\nTTTTCCC\n>Rosalind_0442\nAAATCCC\n>Rosalind_5013\nGGGTGGG\n"
    output = "Rosalind_0498 Rosalind_2391\nRosalind_2391 Rosalind_2323\nRosalind_0498 Rosalind_0442"

    assert_equal output, Rosalind.graph(input, 3)
  end

  def test_graph_exercise
    input  = File.new("../test_data/rosalind_grph.txt").read
    output = File.new("../test_data/sol_grph.txt").read

    assert_equal output, Rosalind.graph(input, 3)
  end
end

