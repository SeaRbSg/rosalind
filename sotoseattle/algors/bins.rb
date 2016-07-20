require_relative './fibo.rb'

class Rosalgors

  def self.bins inputo
    n, m, a, b = inputo.split("\n").map { |e| e.split(" ").map(&:to_i) }
    b.map { |e| binary_search(e, a) + 1 }.join(" ")
  end


  def self.binary_search something, somewhere, carry = 0
    z = somewhere.size
    midpoint = z / 2

    return carry + midpoint if something == somewhere[midpoint]
    return -2 if z == 1

    if something < somewhere[midpoint]
      binary_search(something, somewhere[0...midpoint], carry)
    else
      binary_search(something, somewhere[midpoint..-1], carry + midpoint)
    end
  end
end
