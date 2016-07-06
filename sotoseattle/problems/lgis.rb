require_relative 'perm'

class Rosalind

  def self.lgis inputo
    _n, *series = inputo.split
    series = series.map!(&:to_i)

    grow, drop = [], []
    (0...series.size).to_a.reverse.each do |i|
      grow = laundro(series[i], grow, :<)
      drop = laundro(series[i], drop, :>)
    end

    grow.first.join(' ') + "\n" + drop.first.join(' ')
  end

  def self.laundro c, chains, op
    beta = chains.find { |a| c.send(op, a.first) }
    chains << [c] + beta.to_a
    chains = chains.sort_by(&:size).reverse
  end

end
