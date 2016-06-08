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
    Hash[input_dna.delete("\n").delete(" ").scan(/>(Rosalind_\d+)([AGCTU]+)/)]
  end

  ## Factorial of a number
  def self.facto n
    if n == 0
      1
    else
      n * facto(n - 1)
    end
  end

end
