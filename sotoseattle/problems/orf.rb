require_relative './subs'
require_relative './prot'

class Rosalind

  def self.orf dnas
    sol = []
    fasta(dnas).each { |a| sol += sub_orf(a.last) + sub_orf(revc(a.last)) }
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
    rna_st = rna dna_s
    starts = subs(rna_st, START_CODON)

    starts.map do |i|
      coding_strand = segment rna_st[i-1..-1]
      prot(coding_strand).chomp(EOS) if coding_strand
    end
  end

end


