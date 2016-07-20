class Rosalgors
  @@cache = {}

  def self.fibo n
    @@cache[n] ||= if n <= 0
                     0
                   elsif n == 1
                     1
                   else
                     fibo(n - 1) + fibo(n - 2)
                   end
  end
end
