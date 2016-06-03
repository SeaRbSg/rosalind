require_relative './revc'

class FibonacciRabbits

  def self.fib n, k
    return 1 if n <= 2
    self.fib(n-1, k) + (k * self.fib(n-2, k))
  end

end
