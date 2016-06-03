require 'minitest/autorun'
require 'minitest/pride'

require_relative '../problems/fib.rb'
require_relative '../problems/iev.rb'
require_relative '../problems/fibd.rb'
require_relative '../problems/mrna.rb'
require_relative '../problems/prtm.rb'
require_relative '../problems/grph.rb'
require_relative '../problems/mprt.rb'
require_relative '../problems/cons.rb'
require_relative '../problems/orf.rb'
require_relative '../problems/lcsm.rb'
require_relative '../problems/perm.rb'
require_relative '../problems/revp.rb'

class TestRosalind < Minitest::Test

  def test_dna
    chorizo = 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'
    assert_equal '20 12 17 21', Rosalind.dna(chorizo)
  end

  def test_rna
    assert_equal 'GAUGGAACUUGACUACGUAAAUU', Rosalind.rna('GATGGAACTTGACTACGTAAATT')
  end

  def test_revc
    assert_equal 'ACCGGGTTTT', Rosalind.revc('AAAACCCGGT')
  end

  def test_ipbr
    assert_in_delta 0.78333, MendelKittens.new(2, 2, 2).iprb_law_1, 0.0001
    assert_in_delta 0.84731, MendelKittens.new(30, 20, 16).iprb_law_1, 0.0001
  end

  def test_fib
    assert_equal 19, FibonacciRabbits.fib(5, 3)
    assert_equal 89478485, FibonacciRabbits.fib(28, 2)
  end

  def test_gc_simplest
    assert_in_delta 37.5, Rosalind.gc_content('AGCTATAG'), 0.0001
  end

  def test_gc_longaniza
    chorizo = 'CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGACTGGGAACCTGCGGGCAGTAGGTGGAAT'
    assert_in_delta 60.919540, Rosalind.gc_content(chorizo), 0.0001
  end

  def test_gc
    inputo = ">Rosalind_6404\nCCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCC\nTCCCACTAATAATTCTGAGG\n>Rosalind_5959\nCCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCT\nATATCCATTTGTCAGCAGACACGC\n>Rosalind_0808\nCCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGAC\nTGGGAACCTGCGGGCAGTAGGTGGAAT"
    output = Rosalind.gc(inputo)
    assert_equal 'Rosalind_0808', output.first
    assert_in_delta 60.919540, output.last
  end

  def test_prot
    assert_equal 'MAMAPRTEINSTRING-', Rosalind.prot('AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA')
  end

  def test_subs
    assert_equal [2, 4, 10], Rosalind.subs('GATATATGCATATACTT', 'ATAT')
    assert_equal [1, 3, 9],  Rosalind.subs( 'ATATATGCATATACTT', 'ATAT')
    assert_equal [],         Rosalind.subs( 'ATATATGCATATACTT', 'AAAA')
  end

  def test_hamm
    assert_equal 7, Rosalind.hamm('GAGCCTACTAACGGGAT', 'CATCGTAATGACGGCCT')
  end

  def test_iev
    assert_equal 3.5, MendelKittens.iev([1,0,0,1,0,1])
    assert_equal 7.0, MendelKittens.iev([2,0,0,2,0,2])
    assert_equal 161131.5, MendelKittens.iev([18495, 19225, 19691, 18455, 18627, 18776])
  end

  def test_fibd
    assert_equal 1, FibonacciRabbits.fibd(1, 3)
    assert_equal 1, FibonacciRabbits.fibd(2, 3)
    assert_equal 2, FibonacciRabbits.fibd(3, 3)
    assert_equal 2, FibonacciRabbits.fibd(4, 3)
    assert_equal 3, FibonacciRabbits.fibd(5, 3)
    assert_equal 4, FibonacciRabbits.fibd(6, 3)
  end

  def test_mrna_basic
    assert_equal 12, Rosalind.mrna('MA')
  end

  def test_mrna_exercise
    i = File.new('../test_data/rosalind_mrna.txt').read
    assert_equal 770624, Rosalind.mrna(i)
  end

  def test_prtm
    assert_in_delta 821.392, Rosalind.prtm('SKADYEK'), 0.0001
  end

  def test_prtm_long
    i = File.new('../test_data/rosalind_mrna.txt').read
    assert_in_delta 118465.66184, Rosalind.prtm(i), 0.0001
  end

  def test_prtm_exercise
    i = File.new('../test_data/rosalind_prtm.txt').read
    assert_in_delta 105527.78843, Rosalind.prtm(i), 0.0001
  end

  def test_grph_simple
    input  = ">Rosalind_0498\nAAATAAA\n>Rosalind_2391\nAAATTTT\n>Rosalind_2323\nTTTTCCC\n>Rosalind_0442\nAAATCCC\n>Rosalind_5013\nGGGTGGG\n"
    output = ['Rosalind_0498 Rosalind_2391', 'Rosalind_2391 Rosalind_2323', 'Rosalind_0498 Rosalind_0442']
    assert_equal output, Rosalind.grph(input, 3)
  end

  def test_grph_exercise
    input  = File.new('../test_data/rosalind_grph.txt').read
    output = File.new('../test_data/sol_grph.txt').read
    assert_equal output.split("\n"), Rosalind.grph(input, 3)
  end

  def test_mprt_basic
    out = "B5ZC00\n85 118 142 306 395\nP07204_TRBM_HUMAN\n47 115 116 382 409\nP20840_SAG1_YEAST\n79 109 135 248 306 348 364 402 485 501 614"
    assert_equal out, Rosalind.mprt("A2Z669\nB5ZC00\nP07204_TRBM_HUMAN\nP20840_SAG1_YEAST")
  end

  def test_mprt_exercise
    inputo = File.open('../test_data/rosalind_mprt.txt').read
    output = File.open('../test_data/sol_mprt.txt').read
    assert_equal output, Rosalind.mprt(inputo)
  end

  def test_cons_basic
    inputo = ">Rosalind_1\nATCCAGCT\n>Rosalind_2\nGGGCAACT\n>Rosalind_3\nATGGATCT\n>Rosalind_4\nAAGCAACC\n>Rosalind_5\nTTGGAACT\n>Rosalind_6\nATGCCATT\n>Rosalind_7\nATGGCACT"
    output = ['ATGCAACT',
              'A: 5 1 0 0 5 5 0 0',
              'C: 0 0 1 4 2 0 6 1',
              'G: 1 1 6 3 0 1 0 0',
              'T: 1 5 0 0 0 1 1 6'].join("\n")
    assert_equal output, Rosalind.cons(inputo)
  end

  def test_cons_exercise
    inputo = File.open('../test_data/rosalind_cons.txt').read
    output = File.open('../test_data/sol_cons.txt').read
    assert_equal output, Rosalind.cons(inputo)
  end

  def test_lcsm
    input = ">Rosalind_1\nGATTACA\n>Rosalind_2\nTAGACCA\n>Rosalind_3\nATACA\n"
    assert Rosalind.lcsm(input).include?('TA')
  end

  def test_lcsm_exercise
    skip # too long
    inputo = File.open('../test_data/rosalind_lcsm.txt').read
    output = 'CTGCCCGCAGTCCAATGACGCGCGACGGCAGAAGCCCCAAGCAGCCCCCGAGAAATACTCGTAC'
    assert_equal output, Rosalind.lcsm(inputo)
  end

  def test_perm
    assert_equal "6\n1 2 3\n1 3 2\n2 1 3\n2 3 1\n3 1 2\n3 2 1", Rosalind.perm(3)
  end

  def test_revp
    inputo = 'TCAATGCATGCGGGTCTATATGCAT'
    output = "4 6\n5 4\n6 6\n7 4\n17 4\n18 4\n20 6\n21 4"
    assert_equal output, Rosalind.revp(inputo)
  end

  def test_orf
    inputo = ">Rosalind_99\nAGCCATGTAGCTAACTCAGGTTACATGGGGATGACCCCGCGACTTGGATTAGAGTCTCTTTTGGAATAAGCCTGAATGATCCGAGTAGCATCTCAG"
    output = "M\nMGMTPRLGLESLLE\nMTPRLGLESLLE\nMLLGSFRLIPKETLIQVAGSSPCNLS"
    assert_equal output, Rosalind.orf(inputo)
  end

  def test_orf_exercise
    inputo = File.open('../test_data/rosalind_orf.txt').read
    output = File.open('../test_data/sol_orf.txt').read
    assert_equal output, Rosalind.orf(inputo)
  end

end

