require './dna'

class Rosalind

  def self.cons dna_stuff
    profi = profile fasta(dna_stuff).values
    sol = [consensus(profi)]

    profi.each { |k, v| sol << "#{k}: #{v.join(' ')}" }
    sol.join("\n")
  end

  def self.consensus a_profile
    keys, values = a_profile.keys, a_profile.values

    (0...values.first.size).map do |j|
      keys[values.map { |x| x[j] }.each_with_index.max[1]]
    end.join
  end

  def self.profile strands
    prof = {}
    m, n = strands.size, strands.first.size

    %w[A C G T].map do |nucleotid|
      prof[nucleotid] = (0...n).map do |j|
        strands.count { |s| nucleotid == s[j] }
      end
    end

    prof
  end
end
