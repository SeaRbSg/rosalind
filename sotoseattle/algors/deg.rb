class Rosalgors
  def self.deg inputo
    shit, *g = inputo.split("\n").map { |s| s.split.map(&:to_i) }
    g.flatten.group_by { |e| e }.sort.map { |k, v| v.size }.join(" ")
  end
end
