require_relative './rosalind_k'

class Rosalind

  ## Count all nucleotids in order

  def self.dna_nucleo_count dna_str
    NUCLEOTIDS.keys.sort.map{ |c| dna_str.count c }.join " "
  end

  ## Parse dna strings in FASTA format

  def self.fasta input_dna
    input_dna.delete("\n").delete(" ").scan(/>(Rosalind_\d+)([AGCT]+)/)
  end

end
