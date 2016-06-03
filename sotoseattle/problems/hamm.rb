require_relative './revc'

class Rosalind

  ## compare two strands nucleotid by nucleotid and count differences

  def self.hamm s, t
    s.chars.zip(t.chars).count { |a| a.uniq.size == 2 }
  end

end

