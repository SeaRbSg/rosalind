class Rosalind
  def run args
    ARGV.each do |path|
      name = path.split(/[_.]/)[1]
      warn "# #{name}"
      puts send("cmd_#{name}", parse(File.read(path)))
    end
  end

  def parse s
    s.each_line.map { |l|
      case l
      when /^\s*#|^$/ then
        next
      else
        l.chomp
      end
    }.compact.join "\n"
  end

  def cmd_dna s
    count_dna(s).join " "
  end

  def cmd_rna s
    dna_to_rna s
  end

  def cmd_revc s
    reverse_compliment s
  end

  def cmd_gc s
    gc fasta s
  end

  def gc fasta
    fasta.map { |k, v| [k, gc_content(v)] }.max_by { |k,v| v }
  end

  def gc_content dna
    100.0 * dna.delete("AT").size / dna.size
  end

  def fasta s
    Hash[*s.split(/^>(\w+)\n/).drop(1).map { |ss| ss.delete("\n") }]
  end

  def count_dna dna
    %w[A C G T].map { |nt| dna.count nt }
  end

  def dna_to_rna dna
    dna.tr "T", "U"
  end

  def reverse_compliment dna
    dna.reverse.tr "ATCG", "TAGC"
  end
end
