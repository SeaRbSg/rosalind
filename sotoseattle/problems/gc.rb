require_relative './revc'

class Rosalind

  ## GC content of dna strand

  def self.gc_content dna_str
    100.0 * dna_str.count('GC') / dna_str.size
  end

  ## Pick the label of the dna strand with highest GC content

  def self.gc input_dna
    input_dna.map { |a| [a.first, self.gc_content(a.last)] }
             .max { |a| a.last }
  end

end
