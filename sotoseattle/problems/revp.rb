require_relative './revc'

class Rosalind

  def self.revp yin
    max = yin.size
    yan = Rosalind.complement(yin)
    sol = []

    (0..max-1).each do |pos|
      REVP_EXPLORE.each do |len|
        next if pos + len > max

        if yin.slice(pos, len) == yan.slice(pos, len).reverse
          sol << "#{pos+1} #{len}"
        else
          next
        end
      end
    end

    sol.join("\n")
  end

end
