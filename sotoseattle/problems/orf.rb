require_relative './subs'
require_relative './prot'

class Rosalind

  def self.orf dnas
    sol = []
    fasta(dnas).values.each { |a| sol += sub_orf(a) + sub_orf(revc(a)) }
    sol.uniq.compact.join("\n")
  end

  private
  def self.segment str
    sol = ''
    str.scan(/.{3}/).each do |tri|
      sol << tri
      return sol if STOP_CODONS.include? tri
    end
    nil
  end

  def self.sub_orf dna_s
    rna_st = transcribe dna_s
    starts = find_substrand(rna_st, START_CODON)

    starts.map do |i|
      coding_strand = segment rna_st[i-1..-1]
      encode_protein(coding_strand).chomp(EOS) if coding_strand
    end
  end

end


