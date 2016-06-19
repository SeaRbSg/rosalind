require_relative './splc'

class Rosalind
  def self.tran inputo
    a, b = fasta(inputo).values.map(&:chars)
    transitions = trasversions = 0.0

    a.zip(b).each do |pair|
      next if pair.uniq.size == 1

      pair = pair.sort
      if pair == ['A', 'G'] || pair == ['C', 'T']
        transitions  += 1.0
      else
        trasversions += 1.0
      end
    end

    transitions / trasversions
  end

end
