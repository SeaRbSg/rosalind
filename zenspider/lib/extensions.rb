class Array
  def counts
    result = Hash.new 0

    each do |v|
      result[v] += 1
    end

    result
  end

  def index_hash
    Hash[map.with_index.to_a]
  end

  def paireq
    self[0] == self[1]
  end

  def spc
    join " "
  end

  def sort_by_dict ary
    dict = ary.index_hash

    sort_by { |a| a.chars.map { |v| dict[v] } }
  end

  def sum
    inject :+
  end

  def to_str_mathy
    "{#{join ", "}}"
  end
end

class HashHash < Hash
  def initialize
    super { |h,k| h[k] = {} }
  end
end

class HashArray < Hash
  def initialize
    super { |h,k| h[k] = [] }
  end
end

class HashHashArray < Hash
  def initialize
    super { |h,k| h[k] = HashArray.new }
  end
end

class Integer
  def c m
    n = self

    n.fact / (m.fact * (n-m).fact)
  end

  def fact
    return 1 if self < 2
    self.downto(2).inject(&:*)
  end

  def p m
    n = self

    n.fact / (n-m).fact
  end
end

class String
  def each_slice
    (0..length).map { |n| yield self[n..-1] }
  end

  def each_cons n
    return enum_for(:each_cons, n) unless block_given?
    chars.each_cons(n) do |a|
      yield a.join
    end
  end

  def floats
    words.map(&:to_f)
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

  def words
    split
  end
end
