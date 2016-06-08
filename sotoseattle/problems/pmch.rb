require_relative './grph'

class Rosalind

  def self.pmch chorizo
    fasta(chorizo).values.first.chars
                  .partition { |c| c=='C' || c=='G' }
                  .map { |a| facto (a.size / 2) }
                  .reduce :*
  end

end

