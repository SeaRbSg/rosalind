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
end

class Array
  def sum
    inject :+
  end
end
