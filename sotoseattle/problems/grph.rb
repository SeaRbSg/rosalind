require_relative './gc'

class Rosalind
  def self.grph chorizo, k=3
    input  = Hash[*Rosalind.fasta(chorizo).flatten]
    output = ""

    input.each do |label, strand|
      input.select { |l, s| strand[0, k] == s[-k..-1] && strand != s }
           .each {|l, s| output << "#{l} #{label}\n" }
    end

    output.chomp
  end
end

