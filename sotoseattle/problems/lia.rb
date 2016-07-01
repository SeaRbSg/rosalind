require_relative './iprb'

class Rosalind

  def self.lia k, n
    m = 2**k
    (n..m).map { |i| aja_math(m, i) }.reduce(:+).round(3)
  end

  def self.aja_math m, i
    0.25 ** i *
    0.75 ** (m - i) *
    factorial(m) /
    factorial(i) /
    factorial(m - i)
  end

  def self.factorial n
    return 1 if n < 2
    n.downto(2).reduce(:*)
  end

end
