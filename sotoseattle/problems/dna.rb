require_relative './rosalind_k'

class Rosalind

  ## dna exercise
  def self.dna dna_str
    dna_nucleo_count(dna_str).join ' '
  end

  ## Count all nucleotids in order
  def self.dna_nucleo_count dna_str
    NUCLEIC_ACIDS.keys.sort.map{ |c| dna_str.count c }
  end

  ## Parse dna strings in FASTA format
  def self.fasta input_dna
    input_dna.delete("\n").delete(" ").scan(/>(Rosalind_\d+)([AGCT]+)/)
  end

end
