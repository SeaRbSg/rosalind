require_relative './iprb'

class Rosalind

  def self.iev arr
    input = IEV_BASE.map{|a| a.split('-').map(&:chars)}.zip(arr)

    counting = input.map do |alleles, n|
      alleles[0].product(alleles[1]).count{ |k| k.include? IEV_DOMN } * n
    end

    counting.reduce(:+) * IEV_OFFS / (IEV_CARD ** 2)
  end
end


