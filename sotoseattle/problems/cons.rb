require './dna'

class Rosalind

  def self.cons dna_stuff
    pr = profile   fasta(dna_stuff).values
    cn = consensus pr

    [cn.join, pr.map { |k, v| "#{k}: #{v.join(' ')}" }].join("\n")
  end

  def self.consensus a_profile
    keys, values = a_profile.keys, a_profile.values
    number_chars = values.first.size

    (0...number_chars).map do |i|
      keys[values.map { |x| x[i] }.each_with_index.max[1]]
    end
  end

  def self.profile strands
    Hash[NUCLEIC_ACIDS.keys.map { |nuc| [nuc, count_nucleic(nuc, strands)] }]
  end

  def self.count_nucleic nucl, strands
    number_chars = strands.first.size
    (0...number_chars).map { |i| strands.count { |s| nucl == s[i] } }
  end
end
