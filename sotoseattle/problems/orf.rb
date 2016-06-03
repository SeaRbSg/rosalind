require_relative './subs'
require_relative './prot'

class Rosalind

  def self.orf dnas
    fasta(dnas).values.map do |strand|
      [strand, revc(strand)].map { |x| possible_prots x }
                            .flatten.uniq.compact
    end.join("\n")
  end

  def self.segment str
    fin = str.scan(/.{3}/).index { |x| STOP_CODONS.include? x }
    str[0, fin * 3] if fin
  end

  def self.possible_prots dna_s
    rna = transcribe dna_s
    starts = find_substrand(rna, START_CODON).map { |i| i -= 1 }

    starts.map do |i|
      coding_strand = segment rna[i..-1]
      encode_protein(coding_strand).chomp(EOS) if coding_strand
    end
  end

end
