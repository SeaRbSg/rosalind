require_relative './iprb'

class MendelKittens

  IEV_BASE = %w[AA-AA AA-Aa AA-aa Aa-Aa Aa-aa aa-aa] # the 6 base couples
  IEV_DOMN = 'A'                                     # dominant 4 phenotype
  IEV_CARD = 2.0                                     # allele cardinality
  IEV_OFFS = 2.0                                     # size of litter

  def self.iev arr
    input = IEV_BASE.map{|a| a.split('-').map(&:chars)}.zip(arr)

    counting = input.map do |alleles, n|
      alleles[0].product(alleles[1]).count{ |k| k.include? IEV_DOMN } * n
    end

    counting.reduce(:+) * IEV_OFFS / (IEV_CARD ** 2)
  end

end
