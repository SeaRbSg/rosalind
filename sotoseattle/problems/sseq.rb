require_relative './splc'

class Rosalind

  def self.sseq inputo
    s, t = fasta(inputo).values.map(&:chars)
    indi = find_all_indices(s, t)

    increasing_indices(indi).map{ |x| x += 1 }.join(' ') # assuming solution ∃
  end

  def self.find_all_indices s, t
    indices = t.map do |c|
      s.each_with_index.map { |x, i| x == c ? i : nil }.compact
    end
  end

  def self.increasing_indices indarray, bucket=[]
    return bucket if indarray.empty?

    m = bucket.empty? ? 0 : bucket.last
    basis = indarray.first.select { |n| n > m }

    basis.each do |c|
      sol = increasing_indices(indarray[1..-1], bucket + [c])
      return sol if sol
    end
  end

end
