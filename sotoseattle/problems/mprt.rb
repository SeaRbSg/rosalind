require 'open-uri'

class Rosalind

  def self.mprt bunch_o_proteins, motif = /(?=(N[^P][S|T][^P]))/

    sol = bunch_o_proteins.split.map do |protein|
      u = URI("http://www.uniprot.org/uniprot/#{protein}.fasta")

      strand = open(u).read.split("\n").reject { |a| a.match(/^\>/) }.join

      positions = strand.scan(motif).flatten.map { |s| strand.index(s) + 1 }.join ' '

      [protein, positions] unless positions.empty?
    end

    sol.flatten.compact.join("\n")
  end

end
