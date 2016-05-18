class String
  def words
    split
  end

  def integers
    words.map(&:to_i)
  end

  def floats
    words.map(&:to_f)
  end
end
