require 'set'

class Rosalind
  @@cache = {}

  def self.fibd n, m
    @@cache[n] ||= if n < 0
                     0
                   elsif n < 2
                     1
                   else
                     (2..m).inject(0) { |t, i| t += fibd(n-i, m) }
                   end
  end
end

## I had to try because, dear Sancho, those are not windmills but giants!

# class Rabbit
#   attr_accessor :age, :max_age
#
#   def initialize m
#     @age = 0
#     @max_age = m
#   end
#
#   def tick
#     @age += 1
#   end
#
#   def breeding?
#     @age > 1
#   end
#
#   def goner?
#     @age > @max_age
#   end
#
#   def born?
#     @age > 0
#   end
# end
#
# class Rosalind_Masochistic
#   def self.fibo_kill n, m
#     population = Set.new.add Rabbit.new(m)
#
#     (1..n).each do |t|
#       population.each(&:tick)
#                 .delete_if(&:goner?)
#                 .count(&:breeding?)
#                 .times { population.add Rabbit.new(m) }
#     end
#
#     population.count &:born?
#   end
# end
#
# class TestRosalind_Masoch < Minitest::Test
#   def test_fibonacci_on_steroids
#     assert_equal 1, Rosalind_Masochistic.fibo_kill(1, 3)
#     assert_equal 1, Rosalind_Masochistic.fibo_kill(2, 3)
#     assert_equal 2, Rosalind_Masochistic.fibo_kill(3, 3)
#     assert_equal 2, Rosalind_Masochistic.fibo_kill(4, 3)
#     assert_equal 3, Rosalind_Masochistic.fibo_kill(5, 3)
#     assert_equal 4, Rosalind_Masochistic.fibo_kill(6, 3)
#   end
# end
