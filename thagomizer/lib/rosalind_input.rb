class RosalindInput
  def initialize path
    @path = path
  end

  def ints
    self.lines.map { |x| x.split(/\s/).map(&:to_i) }
  end

  def floats
    self.lines.map { |x| x.split(/\s/).map(&:to_f) }
  end

  def nested_arrays
    self.lines.map { |x| x.split(/\s/) }
  end

  def lines
    File.readlines(@path)
  end

  def int
    File.read(@path).to_i
  end
end
