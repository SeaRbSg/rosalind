require_relative 'perm'

class Node
  attr_accessor :val, :arm

  def initialize v
    @val = v.to_i
    @arm = []
  end

  def add n, oper
    # if @val.send(oper, n.val)
    if @val < n.val
      @arm.map { |a| a.add(n, oper) }
      @arm << n
      @arm.uniq!
    end
  end

  def relink
    return if @arm.empty?
    @arm.each do |m|
    end
  end

  def include? n
    return true  if @val == n.val
    return false if @arm.empty?
    @arm.each {|a| a.include? n}
    false
  end

  def longest
    return @val if @arm.empty?
    @arm.map { |a| [@val, a.longest].flatten }.max_by(&:size)
  end

  def to_s
    "#{@val} " + @arm.map { |a| "( #{a} )" }.join(', ')
  end
end

class Rosalind

  def self.lgis chori
    ups(chori) #+ "\n" + down(chori)
  end

  def self.ups chori
    _n, *series = chori.split
    series.map!(&:to_i)

    root = Node.new(0)
    series.each do |x|
      root.add(Node.new(x), '<')
      root.relink
    end

    # puts root.to_s
    sol = root.longest
    # p sol
    sol.shift
    sol.join ' '
  end

  # def self.down chori
  #   _n, *series = chori.split(/\s/).map(&:to_i)
  #
  #   forest = []
  #   series.each do |x|
  #     n = Node.new(x)
  #     forest.each { |t| t.add(n, '>') }
  #     forest << n #unless forest.any? {|t| t.include? n}
  #   end
  #
  #   forest.map(&:longest).max_by(&:size)
  # end




  # def self.lgis chori
  #   _n, *series = chori.split(/\s/).map(&:to_i)
  #
  #   upwards, downers = [], []
  #   series.each do |x|
  #     upwards = blabla upwards, x, '>'
  #     downers = blabla downers, x, '<'
  #   end
  #
  #   upwards.max_by(&:size).join(' ') + "\n" + downers.max_by(&:size).join(' ')
  # end
  #
  # def self.blabla forest, x, oper
  #   forest << [x] unless forest.include?([x]) || forest.any? {|a| a.include? x}
  #   growth= []
  #   forest.each do |tree|
  #     if x.send(oper, tree.last)
  #       growth << tree.dup
  #       tree << x
  #     end
  #   end
  #
  #   forest + growth
  # end

end

