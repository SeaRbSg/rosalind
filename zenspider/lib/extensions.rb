class Integer
  def p m
    n = self

    n.fact / (n-m).fact
  end

  def fact
    self.downto(2).inject(&:*)
  end
end

class String
  def words
    split
  end

  def integers
    words.map(&:to_i)
  end

  def indicies t
    idx, hits = 0, []
    while idx = index(t, idx) do
      idx += 1
      hits << idx
    end
    hits
  end

  def floats
    words.map(&:to_f)
  end

  def each_cons n
    return enum_for(:each_cons, n) unless block_given?
    chars.each_cons(n) do |a|
      yield a.join
    end
  end
end

class Array
  def counts
    result = Hash.new 0

    each do |v|
      result[v] += 1
    end

    result
  end

  def sum
    inject :+
  end
end
