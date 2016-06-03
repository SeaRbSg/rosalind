require_relative './revc'

class Rosalind

  ## gc exercise == pick the label of the dna strand with highest GC content
  def self.gc dna_str
    fasta(dna_str).to_a.map{ |lab, str| [lab, self.gc_content(str)] }.max_by &:last
  end

  ## GC content of dna strand
  def self.gc_content dna_str
    100.0 * dna_str.count('GC') / dna_str.length
  end

end
