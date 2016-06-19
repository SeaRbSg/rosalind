require_relative './revc'

class Rosalind

  def self.sign n
    n = n.to_i
    base = (1..n).to_a

    rango = base + (-n..-1).to_a
    perms = rango.repeated_permutation(n)
                 .select { |a| a.map(&:abs).sort == base }

    ([perms.size.to_s] + perms.map {|a| a.join(' ')} ).join("\n")
  end

end
