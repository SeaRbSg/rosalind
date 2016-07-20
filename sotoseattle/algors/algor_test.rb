require 'minitest/autorun'
require 'minitest/pride'

require_relative './bins.rb'

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
end

