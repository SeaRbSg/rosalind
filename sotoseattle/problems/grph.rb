require_relative './gc'

class Rosalind
  def self.grph chorizo, k=3
    input  = fasta(chorizo)
    output = input.map do |label, strand|
      input.select { |l, s| strand[0, k] == s[-k..-1] && strand != s }
           .map {|l, s| "#{l} #{label}" }
    end

    output.flatten.compact
  end
end

