require_relative 'hamm'
require_relative 'subs'

class Rosalind

  def self.lcsm read_file
    strands = fasta(read_file).values
    base = strands.shift.chars

    [*1..base.size].reverse.each do |i|
      base.each_cons(i) do |q|
        w = q.join
        return w if strands.all? { |a| a.include?(w) }
      end
    end
  end

end
