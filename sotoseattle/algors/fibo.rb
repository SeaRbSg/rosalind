class Rosalind
  @@cache = {}

  def self.fibo n
    @@cache[n] ||= if n <= 0
                     0
                   elsif n == 1
                     1
                   else
                     fibo(n - 1) + fibo(n - 2)
                     # (2..m).inject(0) { |t, i| t += self.fibd(n-i, m) }
                   end
  end
end
