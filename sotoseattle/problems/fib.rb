require_relative './revc'

require 'minitest/autorun'
require 'minitest/pride'

class Rosalind

  ## Fibonaci with k multiple rabbit pairs

  def self.fibo n, k
    return 1 if n <= 2
    self.fibo(n-1, k) + (k * self.fibo(n-2, k))
  end

end

class TestRosalind < Minitest::Test
  def test_fibonacci_on_steroids
    assert_equal 19, Rosalind.fibo(5, 3)
    assert_equal 89478485, Rosalind.fibo(28, 2)
  end
end
