require_relative './subs'
require_relative './prot'

class Rosalind

  ## splc exercise == splice dna removing introns and converting to protein
  def self.splc chucho
    strands = fasta(chucho).values
    dna_str = strands.shift

    strands.each do |intron|
      dna_str = dna_str.split(intron).flatten.join
    end

    encode_protein(transcribe dna_str).chomp(EOS)
  end

  class << self
    alias_method :splice, :splc
  end

end
