require "extensions"
require "helpers"

class Rosalind
  include Helpers

  def run args
    ARGV.each do |path|
      name = path.split(/[_.]/)[1]
      name = File.basename path, ".txt" if name.empty?
      warn "# #{name}: #{path}"
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

  ##
  # Commands

  def cmd_bins s
    n, m, *rest = s.integers
    ary = rest[0, n]
    ints = rest[n, m]

    ints.map { |i| ary.bsearch_index { |x| i - x } || -2 }.map(&:succ).line
  end

  def cmd_cons s
    profile   = profile s
    consensus = consensus profile
    profile   = DNA.keys.map { |c| "#{c}: #{profile.map { |h| h[c] }.join(" ")}" }
    [consensus, *profile]
  end

  def cmd_deg s
    _, _, *r = s.integers
    edges = r.each_slice 2
    count = Hash.new 0

    edges.each do |a, b|
      count[a] += 1
      count[b] += 1
    end

    count.sort.map(&:last).line
  end

  def cmd_dna s
    count_dna(s).line
  end

  def cmd_fib s
    fib(*s.integers)
  end

  def cmd_fibd s
    n, m = s.integers

    fibd n, m
  end

  def cmd_fibo s
    fib(s.integers.first, 1)
  end

  def cmd_gc s
    gc fasta s
  end

  def cmd_grph s
    dnas = fasta s

    h = HashHashArray.new

    dnas.each do |k, v|
      pre, suf = v[0,3], v[-3,3]
      h[pre][:pre] << k
      h[suf][:suf] << k
    end

    h.flat_map { |_, v| v[:suf].product v[:pre] }.reject(&:paireq).map(&:spc)
  end

  def cmd_hamm s
    a, b = s.lines.map(&:chomp)
    hamm a, b
  end

  def cmd_inod s
    n = s.integers.first

    n - 2
  end

  def cmd_iprb s
    k, m, n = s.integers
    recessive k, m, n
  end

  def cmd_lcsm s
    first, *rest = fasta(s).values

    first.length.downto(2).each do |n|
      v = first.each_cons(n).find { |sub| rest.all? { |ss| ss.include? sub } }
      return v if v
    end
  end

  def cmd_lcsq s
    a, b = fasta(s).values

    subsequence a, b
  end

  def cmd_lexf s
    a = s.words
    l = a.pop.to_i

    a.repeated_permutation(l).map(&:join)
  end

  def cmd_lexv s
    d = s.words
    l = d.pop.to_i

    a = (1..l).flat_map { |n| d.repeated_permutation(n).to_a.map(&:join) }

    a.sort_by_dict d
  end

  def cmd_lgis s
    max, *ary = s.integers

    a = lgis(ary).line
    b = lgis(ary.reverse).reverse.line
    [a, b]
  end

  def cmd_lia s
    m, n = s.integers

    m = 2**m

    (n..m).inject(0.0) { |r, i| r + m.c(i) * 0.25**i * 0.75**(m - i) }
  end

  def cmd_long s
    candidates = fasta(s).values

    candidates.flat_map.with_index { |first, i|
      warn "%d/%d" % [i+1, candidates.size]
      rest = candidates-[first]
      find_joins first, rest
    }.compact
  end

  def cmd_maj s
    k, n, *rest = s.integers

    rows = rest.each_slice n

    rows.map { |row|
      h = Hash.new 0
      row.each do |x|
        h[x] += 1
      end
      h.keys.find { |x| h[x] > n/2 } || -1
    }.line
  end

  def cmd_mrna s
    counts = RNA_CODON.values.counts

    "#{s}.".chars.inject(1) { |n, c| (n * counts[c]) % 1_000_000 }
  end

  def cmd_mprt s
    prots = proteins s.words

    grep_protein prots, /N[^P][ST][^P]/
  end

  def cmd_orf s
    dna = fasta_string s

    dna_to_prots(dna).uniq
  end

  def cmd_perm s
    n = s.to_i
    p = 1.upto(n).to_a.permutation
    [p.size, p.map { |a| a.line }]
  end

  def cmd_pmch s
    rna = fasta_string s

    count = count_chars(rna)

    count["A"].fact * count["G"].fact
  end

  def cmd_pper s
    m, n = s.integers

    m.p(n) % 1_000_000
  end

  def cmd_prob s
    dna, *probs = s.words

    prob(dna, probs.map(&:to_f)).map { |f| "%.3f" % f }.line
  end

  def cmd_prot s
    rna_to_prot s
  end

  def cmd_prtm s
    "%.3f" % s.chars.map { |c| AA_WEIGHT[c] }.sum
  end

  def cmd_revc s
    reverse_compliment s
  end

  def cmd_revp s
    s = fasta_string s

    (4..12).flat_map { |length|
      s.each_cons(length).with_index.map { |ss, i|
        "#{i+1} #{length}" if ss == reverse_compliment(ss)
      }
    }.compact
  end

  def cmd_rna s
    dna_to_rna s
  end

  def cmd_seto s
    n, a, b = s.delete("{}").lines
    n = n.to_i
    a = a.integers
    b = b.integers
    s = (1..n).to_a

    [a | b, a & b, a - b, b - a, s - a, s - b].map(&:to_str_mathy)
  end

  def cmd_sseq s
    dna, pat = fasta(s).values

    indicies(dna, pat).line
  end

  def cmd_sset s
    n = s.integers.first

    (2 ** n) % 1_000_000
  end

  def cmd_sign s
    n = s.integers.first

    perms = signed_permutation n

    [perms.length, perms.map { |a| a.line }]
  end

  def cmd_splc s
    h = fasta s

    dna = h.delete h.keys.first
    dna.gsub! Regexp.union(*h.values), ""

    rna_to_prot dna_to_rna dna
  end

  def cmd_subs s
    s, t = s.lines.map(&:chomp)
    s.indicies(t).line
  end

  def cmd_tran s
    s1, s2 = fasta(s).values

    a, b = count_mutations s1, s2

    a / b
  end

  def cmd_tree s
    max, *edges = s.integers

    max - (edges.size/2) - 1
  end
end
