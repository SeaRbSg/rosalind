class Rosalind
  def run s
    puts %w[A C G T].map { |nt| s.count nt }.join " "
  end
end

if __FILE__ == $0 then
  Rosalind.new.run ARGF.read
end
