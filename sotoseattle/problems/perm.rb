require_relative 'hamm'

class Rosalind

  def self.perm n
    a = [*1..n].permutation.map{|x| x.join(" ")}
    ([a.size] + a).join("\n")
  end

end
