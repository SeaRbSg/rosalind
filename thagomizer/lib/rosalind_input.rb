class RosalindInput
  def initialize path
    @path = path
  end

  def ints
    self.lines.map { |x| x.split(/ /).map(&:to_i) }
  end

  def lines
    File.read(@path).split(/\n/)
  end
end
