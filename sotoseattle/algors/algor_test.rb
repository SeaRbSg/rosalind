require 'minitest/autorun'
require 'minitest/pride'

require_relative './maj.rb'
require_relative './deg.rb'

class TestRosalind < Minitest::Test
  def test_fibd
    assert_equal 8, Rosalgors.fibo(6)
  end

  def test_bins_simple
    assert_equal "4 1 -1 -1 4 2", Rosalgors.bins("5\n6\n10 20 30 40 50\n40 10 35 15 40 20")
    assert_equal 0, Rosalgors.binary_search(10, [10, 20, 30, 40, 50])
    assert_equal 1, Rosalgors.binary_search(20, [10, 20, 30, 40, 50])
    assert_equal 2, Rosalgors.binary_search(30, [10, 20, 30, 40, 50])
    assert_equal 3, Rosalgors.binary_search(40, [10, 20, 30, 40, 50])
    assert_equal 4, Rosalgors.binary_search(50, [10, 20, 30, 40, 50])
    assert_equal -2, Rosalgors.binary_search(35, [10, 20, 30, 40, 50])
    assert_equal -2, Rosalgors.binary_search(5, [10, 20, 30, 40, 50])
    assert_equal -2, Rosalgors.binary_search(15, [10, 20, 30, 40, 50])
    assert_equal -2, Rosalgors.binary_search(99, [10, 20, 30, 40, 50])
  end

  def test_bins_exercise
    inputo = File.open('../test_data/rosalind_bins.txt').read
    output = File.open('../test_data/sol_bins.txt').read
    assert_equal output, Rosalgors.bins(inputo)
  end

  def test_maj_simple
    assert_equal "5 7 -1 -1", Rosalgors.maj("4 8\n5 5 5 5 5 5 5 5\n8 7 7 7 1 7 3 7\n7 1 6 5 10 100 1000 1\n5 1 6 7 1 1 10 1")
  end

  def test_maj_exercise
    inputo = File.open('../test_data/rosalind_maj.txt').read
    output = File.open('../test_data/sol_maj.txt').read
    assert_equal output, Rosalgors.maj(inputo)
  end

  def test_deg_simple
    assert_equal "2 4 2 2 2 2", Rosalgors.deg("6 7\n1 2\n2 3\n6 3\n5 6\n2 5\n2 4\n4 1")
  end

  def test_deg_exercise
    inputo = File.open('../test_data/rosalind_deg.txt').read
    output = File.open('../test_data/sol_deg.txt').read
    assert_equal output, Rosalgors.deg(inputo)
  end

end

