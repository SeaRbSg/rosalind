require './dna'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind

  def self.cons dna_stuff
    strs  = fasta(dna_stuff).map { |a| a.last }

    profi = profile(strs)
    sol = [consensus(profi)]

    profi.each { |k, v| sol << "#{k}: #{v.join(' ')}" }
    sol.join("\n")
  end

  def self.consensus a_profile
    keys, values = a_profile.keys, a_profile.values

    (0...values.first.size).map do |j|
      keys[values.map { |x| x[j] }.each_with_index.max[1]]
    end.join
  end

  def self.profile strands
    prof = {}
    m, n = strands.size, strands.first.size

    %w[A C G T].map do |nucleotid|
      prof[nucleotid] = (0...n).map do |j|
        strands.count { |s| nucleotid == s[j] }
      end
    end

    prof
  end
end

class TestRosalind < Minitest::Test
  def test_consensus_basic
    output = ['ATGCAACT',
              'A: 5 1 0 0 5 5 0 0',
              'C: 0 0 1 4 2 0 6 1',
              'G: 1 1 6 3 0 1 0 0',
              'T: 1 5 0 0 0 1 1 6'].join("\n")

    assert_equal output, Rosalind.cons(DATA.read)
  end

  def test_consensus_basic
    inputo = File.open('../test_data/rosalind_cons.txt').read
    output = File.open('../test_data/sol_cons.txt').read

    assert_equal output, Rosalind.cons(inputo)
  end
end

__END__
>Rosalind_1
ATCCAGCT
>Rosalind_2
GGGCAACT
>Rosalind_3
ATGGATCT
>Rosalind_4
AAGCAACC
>Rosalind_5
TTGGAACT
>Rosalind_6
ATGCCATT
>Rosalind_7
ATGGCACT
