require_relative './grph'

class Rosalind

  def self.long inputo
    amalgamator fasta(inputo).values
  end

  def self.amalgamator strands, composite = nil
    return composite if strands.size == 0

    h = composite || strands.pop

    strands.each do |l|
      if composite = velcro(h, l)
        strands.delete(l)
        return amalgamator(strands, composite)
      end
    end
  end

  def self.velcro(hook_s, loop_s)
    zh, zl   = hook_s.size, loop_s.size
    (zl/2..zl).to_a.each do |i|
      return hook_s + loop_s[i..-1] if loop_s.slice(0, i) == hook_s[zh-i..-1]
      return loop_s + hook_s[i..-1] if hook_s.slice(0, i) == loop_s[zl-i..-1]
    end
    nil
  end

end
