class Rosalind

  def self.rear inputo
    inputo.split(/\n+/).map {|s| s.split(' ').map(&:to_i)}
          .each_slice(2).map { |x, y| [switcheroo(x, y), switcheroo(y, x)].min }
          .join(" ")
  end

  def self.switcheroo wip, goal, n = 0
    return n if wip == goal

    [basic_swap(wip, goal, n),
     basic_swap(wip.reverse, goal.reverse, n),
     slingshoot(wip, goal, n)].compact.min
  end

  def self.basic_swap wip, goal, n
    to, from = switchers(wip, goal)
    switcheroo(flipper(wip, to, from), goal, n+1)
  end

  def self.slingshoot wip, goal, n
    to, from = switchers(wip, goal)
    if pivot = index_first_right(wip[to..from], goal[to..from])
      pivot = pivot + to + 1
      return switcheroo(flipper(wip, pivot, from), goal, n+1) if pivot < from
    end
  end

  def self.switchers wip, goal
    a = index_first_wrong(wip, goal)
    b = wip.find_index(goal[a])
    [a, b]
  end

  def self.flipper arr, i, j
    flip = arr[i..j].reverse
    arr[0...i] + flip + arr[j+1..-1]
  end

  def self.index_first_wrong a, b
    (0..b.size).find { |i| a[i] != b[i] }
  end

  def self.index_first_right a, b
    (0..b.size).find { |i| a[i] == b[i] }
  end

end
