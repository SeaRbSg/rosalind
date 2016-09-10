require "../lib/rosalind_input"

n_mos, $n_litters = RosalindInput.new("fibd.txt").ints[0]

$results = {}

def fib n
  $results[n] ||= case
                  when n < 0
                    0
                  when n < 2
                    1
                  else
                    (2..$n_litters).map { |x| fib(n - x) }.inject(:+)
                  end
end

puts fib(n_mos)
