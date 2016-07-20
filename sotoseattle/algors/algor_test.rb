require 'minitest/autorun'
require 'minitest/pride'

require_relative './fibo.rb'

class TestRosalind < Minitest::Test
  def test_fibd_exercise
    assert_equal 8, Rosalind.fibo(6)
  end
end

