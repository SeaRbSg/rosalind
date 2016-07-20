require_relative './bins.rb'

class Rosalgors

  def self.maj inputo
    nm, *chorizos = inputo.split("\n").map { |e| e.split.map(&:to_i) }
    m = nm.last

    chorizos.map do |a|
      frequent = a.group_by { |i| i }.values.find{ |e| e.size > m/2 }
      frequent ? frequent.first : -1
    end.join(" ")
  end

end
