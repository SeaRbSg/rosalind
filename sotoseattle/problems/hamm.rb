require_relative './revc'

class Rosalind

  ## hamm exercise == compare two strands to count nucleic acid differences
  def self.hamm s, t
    s.chars.zip(t.chars).count { |a| a.uniq.size == 2 }
  end

  class << self
    alias_method :hamming_distance, :hamm
  end

end

