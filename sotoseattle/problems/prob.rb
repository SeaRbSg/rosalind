require_relative 'iprb'

class Rosalind

  def self.prob inputo
    s, *arr = inputo.split
    s = s.chars

    sol = arr.map do |x|
      p_gc, p_at = x.to_f, 1.0 - x.to_f

      s.map { |c| Math.log10 (c =~ /[CG]/ ? p_gc : p_at) / 2.0 }.reduce(0, :+)
    end

    sol.map{|x| x.round(3)}.join ' '
  end

end
