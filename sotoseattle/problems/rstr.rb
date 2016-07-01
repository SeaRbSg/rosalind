require_relative './prob'

class Rosalind

  def self.rstr inputo
    n, gc, strand = inputo.split("\s")

    logprob = prob(strand + ' ' + gc).to_f

    no_prob = 1 - (10 ** logprob)

    1 - no_prob ** n.to_f
  end

end
