require_relative './subs'
require_relative './prot'

class Rosalind

  ## splc exercise == splice dna removing introns and converting to protein
  def self.splc input_data
    dna_str, *introns = *fasta(input_data).values

    encode_protein(transcribe(splice_exons(dna_str, introns))).chomp(EOS)
  end

  def self.splice_exons dna_str, introns
    introns.each { |x| dna_str = dna_str.split(x).join }
    dna_str
  end

  class << self
    alias_method :splice, :splc
  end

end
