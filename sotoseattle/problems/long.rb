require_relative './grph'

class Rosalind

  def self.long inputo
    feed = fasta(inputo).values
    long_laundro(feed)
  end

  def self.xxx strands
    return false if strands.size == 1
    sol = []
    tot = 1_000_000
    strands.each do |base|
      pepe = strands - [base]
      to_add, to_rmv = pepe.map { |s| common_concat(base, s) }.min { |a| a.first.size }
      if to_add.size < tot
        tot = to_add.size
        sol = pepe + [to_add] - [to_rmv]
      end
    end
    sol
  end

  def self.long_laundro strands
    return strands.first if strands.size == 1
    while juan = xxx(strands) do
      # p strands
      strands = juan
    end
    strands.first
  end

  def self.common_concat s, t
    st, ts= concat(s, t), concat(t, s)
    st.size > ts.size ? [ts, s] : [st, t]
  end

  def self.concat s, t
    if t.size < s.size && (sol = concat_inside(s, t))
      return sol
    elsif (sol = concat_tailed(s, t))
      return sol
    else
      s + t
    end
  end

  def self.concat_inside s, t
    z = s.size
    q = t.size
    (0..z-q-1).each do |i|
      return s if s.slice(i,q) == t
    end
    nil
  end

  def self.concat_tailed s, t
    z = s.size
    q = t.size
    (1..[z, q].min).to_a.reverse.each do |i|
      if s[-i..-1] == t[0..i-1]
        return (s[0..(z-i-1)] + t)
      end 
    end
    nil
  end

end
