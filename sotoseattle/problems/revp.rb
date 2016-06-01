require_relative './revc'
require_relative './subs'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind

  def self.reverse_pals yin
    max = yin.size
    yan = Rosalind.compl(yin)
    sol = []

    (0..max-1).each do |pos|
      (4..max-pos).step(2).each do |len|
        if yin.slice(pos, len) == yan.slice(pos, len).reverse
          sol << "#{pos+1} #{len}" 
        end
      end
    end

    sol.join("\n")
  end

end

class TestRosalind < Minitest::Test
  def test_count_nucleothingies
    inputo = 'TCAATGCATGCGGGTCTATATGCAT'
    output = "4 6\n5 4\n6 6\n7 4\n17 4\n18 4\n20 6\n21 4"
    assert_equal output, Rosalind.reverse_pals(inputo)
  end
end

# f = File.new('../test_data/rosalind_revp.txt')
# o = Rosalind.reverse_pals(Rosalind.fasta(f.read).first.last)
# File.new('./sol.txt', 'w').write(o)

