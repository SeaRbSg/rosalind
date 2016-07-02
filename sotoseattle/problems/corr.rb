require_relative './revc'

class Rosalind

  def self.corr inputo
    original = fasta(inputo).values
    rev_comp = original.map { |read| reverse_complement(read) }
    duplicat = original.select { |read| original.count(read) > 1 }

    goodones = rev_comp + duplicat
    fuck_ups = original - goodones

    fuck_ups.map do |bad|
      correct = goodones.find { |good| hamming_distance(bad, good) == 1 }
      "#{bad}->#{correct}"
    end.join("\n")
  end

end
