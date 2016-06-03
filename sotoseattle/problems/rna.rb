require_relative './dna'

class Rosalind

  ## rna exercise == dna to rna transcription
  def self.rna dna_str
    dna_str.gsub('T', 'U')
  end

  class << self
    alias_method :transcribe, :rna
  end

end
