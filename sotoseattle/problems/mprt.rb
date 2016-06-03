require 'open-uri'

class Rosalind

  def self.fasto input_prot
    input_prot.split("\n").reject { |a| a.match(/^\>/) }.join
  end

  def self.urify proto
    basic = proto.match(PROTEIN_BASIC)[1]
    URI("http://www.uniprot.org/uniprot/#{basic}.fasta")
  end

  def self.mprt proteins
    sol = []

    proteins.split.each do |proto|
      strand    = fasto open(urify(proto)).read
      positions = strand.scan(N_GLYCOSYLATION).flatten
                  .map { |s| strand.index(s) + 1 }
                  .join ' '

      (sol << proto << positions) unless positions == ''
    end

    sol.join("\n")
  end
end
