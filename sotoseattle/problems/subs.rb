require_relative './revc'

class Rosalind

  ## Find where a substring t shows up in s

  def self.subs s, t
    sol = []
    acc = 0
    loop do
      i = s.index(t)
      return sol unless i
      acc += i + 1
      sol << acc
      s = s[i+1..-1]
    end
  end

end
