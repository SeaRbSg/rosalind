require 'minitest/autorun'
require 'minitest/pride'

require_relative './rosa_graphs.rb'
require_relative './maj.rb'

class TestRosaGraphs < Minitest::Test

  def test_deg_simple
    assert_equal "2 4 2 2 2 2", UndirGraph.new("6 7\n1 2\n2 3\n6 3\n5 6\n2 5\n2 4\n4 1").deg
  end

  def test_deg_exercise
    inputo = File.open('../test_data/rosalind_deg.txt').read
    output = File.open('../test_data/sol_deg.txt').read
    assert_equal output, UndirGraph.new(inputo).deg
  end

  def test_ddeg_simple
    assert_equal "3 5 5 5 0", UndirGraph.new("5 4\n1 2\n2 3\n4 3\n2 4").ddeg
  end

  def test_ddeg_exercise
    inputo = File.open('../test_data/rosalind_ddeg.txt').read
    output = File.open('../test_data/sol_ddeg.txt').read
    assert_equal output, UndirGraph.new(inputo).ddeg
  end

  def test_cc_simple
    inputo = "12 13\n1 2\n1 5\n5 9\n5 10\n9 10\n3 4\n3 7\n3 8\n4 8\n7 11\n8 11\n11 12\n8 12"
    assert_equal 3, UndirGraph.new(inputo).cc
  end

  def test_cc_exercise
    inputo = File.open('../test_data/rosalind_cc.txt').read
    assert_equal 99, UndirGraph.new(inputo).cc
  end

  def test_cyclic?
    refute DirGraph.new("2 1\n1 2").cyclic?
    assert DirGraph.new("4 4\n4 1\n1 2\n2 3\n3 1").cyclic?
    refute DirGraph.new("4 3\n4 3\n3 2\n2 1").cyclic?
  end

  def test_dag
    inputo = "3\n\n2 1\n1 2\n\n4 4\n4 1\n1 2\n2 3\n3 1\n\n4 3\n4 3\n3 2\n2 1"
    assert_equal "1 -1 1", RosalindGraphs.dag(inputo)
  end

  def test_dag_exercise
    inputo = File.open('../test_data/rosalind_dag.txt').read
    output = "-1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -1 1 1 1 -1 -1 1 1 -1"
    assert_equal output, RosalindGraphs.dag(inputo)
  end

  def test_squacycle?
    assert UndirGraph.new( "4 5\n3 4\n4 2\n3 2\n3 1\n1 2\n").squacycle?
    assert UndirGraph.new( "4 5\n3 4\n4 1\n1 2\n3 2\n").squacycle?
    refute UndirGraph.new("4 4\n1 2\n3 4\n2 4\n4 1").squacycle?
    refute UndirGraph.new("3 2\n1 2\n2 3").squacycle?
    refute UndirGraph.new("6 6\n1 2\n2 3\n3 4\n4 5\n5 6\n6 1\n").squacycle?
    refute UndirGraph.new("5 5\n1 2\n2 3\n3 4\n4 5\n5 1\n").squacycle?
    assert UndirGraph.new("5 5\n1 2\n2 3\n3 4\n4 5\n5 2\n").squacycle?
  end

  def test_sq_exercise
    inputo = File.open('../test_data/rosalind_sq.txt').read
    output = "-1 -1 1 -1 -1 -1 -1 -1 1 -1 1 -1 -1 -1 -1 -1 -1"
    assert_equal output, RosalindGraphs.sq(inputo)
  end

end

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

end

