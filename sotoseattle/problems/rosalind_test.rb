require 'minitest/autorun'
require 'minitest/pride'

require_relative '../problems/fib.rb'
require_relative '../problems/iev.rb'
require_relative '../problems/fibd.rb'
require_relative '../problems/prtm.rb'
require_relative '../problems/mprt.rb'
require_relative '../problems/cons.rb'
require_relative '../problems/orf.rb'
require_relative '../problems/lcsm.rb'
require_relative '../problems/revp.rb'
require_relative '../problems/lia.rb'

require_relative '../problems/tree.rb'
require_relative '../problems/pmch.rb'
require_relative '../problems/pper.rb'
require_relative '../problems/prob.rb'
require_relative '../problems/lgis.rb'
require_relative '../problems/tran.rb'
require_relative '../problems/lexf.rb'
require_relative '../problems/sign.rb'
require_relative '../problems/sseq.rb'
require_relative '../problems/long.rb'

require_relative '../problems/inod.rb'
require_relative '../problems/sset.rb'
require_relative '../problems/seto.rb'
require_relative '../problems/rstr.rb'
require_relative '../problems/kmp.rb'
require_relative '../problems/corr.rb'

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

  def test_lia_basic
    assert_equal 0.684, Rosalind.lia(2, 1)
  end

  def test_lia_example
    assert_equal 0.374, Rosalind.lia(7, 34)
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

  def test_splc
    inputo = ">Rosalind_10\nATGGTCTACATAGCTGACAAACAGCACGTAGCAATCGGTCGAATCTCGAGAGGCATATGGTCACATGATCGGTCGAGCGTGTTTCAAAGTTTGCGCCTAG\n>Rosalind_12\nATCGGTCGAA\n>Rosalind_15\nATCGGTCGAGCGTGT"
    output = 'MVYIADKQHVASREAYGHMFKVCA'
    assert_equal output, Rosalind.splc(inputo)
  end

  def test_splc_exercise
    inputo = File.open('../test_data/rosalind_splc.txt').read
    output = 'MARPTPQPICLCQCERLCITIGHSILSPSDMSLHYDHHKEREPGISVGIKVPTTHGGTTLRQFFPPRVDDISLPNPSPLRSQLDHKELPQSAPLFMAASRCIVYLGLANSTERTSNRENVHNKSWDRTHTGCDSTPGTGFLTGPPYMAVVIRNPQMTILQLVLHWQGYRALCTEVGHGPRPTVIHV'
    assert_equal output, Rosalind.splc(inputo)
  end

  def test_pmch_basic
    assert_equal 12, Rosalind.pmch( ">Rosalind_23\nAGCUAGUCAU")
  end

  def test_pmch_exercise
    inputo = File.open('../test_data/rosalind_pmch.txt').read
    output = 18172405820056795525404426240000000
    assert_equal output, Rosalind.pmch(inputo)
  end

  def test_pper_basic
    assert_equal 51200, Rosalind.pper( "21 7")
  end

  def test_pper_exercise
    assert_equal 587200, Rosalind.pper( "91 9")
  end

  def test_tree_basic
    assert_equal 3, Rosalind.tree( "10\n1 2\n2 8\n4 10\n5 9\n6 10\n7 9")
  end

  def test_tree_exercise
    inputo = File.open('../test_data/rosalind_tree.txt').read
    assert_equal 39, Rosalind.tree(inputo)
  end

  def test_prob_basic
    inputo = "ACGATACAA\n0.129 0.287 0.423 0.476 0.641 0.742 0.783"
    output = "-5.737 -5.217 -5.263 -5.36 -5.958 -6.628 -7.009"
    assert_equal output, Rosalind.prob(inputo)
  end

  def test_prob_exercise
    inputo = File.open('../test_data/rosalind_prob.txt').read
    output = "-81.636 -74.244 -67.561 -65.318 -62.807 -61.224 -60.223 -60.521 -61.166 -62.312 -65.318 -66.807 -71.096 -78.764"
    assert_equal output, Rosalind.prob(inputo)
  end

  def test_tran_basic
    inputo = ">Rosalind_0209\nGCAACGCACAACGAAAACCCTTAGGGACTGGATTATTTCGTGATCGTTGTAGTTATTGGA\nAGTACGGGCATCAACCCAGTT\n>Rosalind_2200\nTTATCTGACAAAGAAAGCCGTCAACGGCTGGATAATTTCGCGATCGTGCTGGTTACTGGC\nGGTACGAGTGTTCCTTTGGGT"
    output = 1.21428571429
    assert_in_delta output, Rosalind.tran(inputo), 0.0001
  end

  def test_tran_basic
    inputo = File.open('../test_data/rosalind_tran.txt').read
    output = 2.1666666666666665
    assert_in_delta output, Rosalind.tran(inputo), 0.0001
  end

  def test_lexf_basic
    inputo = "T A G C\n2"
    output = "TT\nTA\nTG\nTC\nAT\nAA\nAG\nAC\nGT\nGA\nGG\nGC\nCT\nCA\nCG\nCC\n"
    assert_equal output, Rosalind.lexf(inputo)
  end

  def test_lexf_exercise
    inputo = File.open('../test_data/lexf.txt').read
    output = File.open('../test_data/lexf_results.txt').read

    sol = Rosalind.lexf(inputo)
    File.open("../test_data/sol_lexf.txt", 'w') { |f| f.write(sol) }
    out = File.open("../test_data/sol_lexf.txt").read

    assert_equal output, out
  end

  def test_sign_basic
    output = "8\n-1 -2\n-1 2\n1 -2\n1 2\n-2 -1\n-2 1\n2 -1\n2 1"
    assert_equal output.split("\n").sort, Rosalind.sign(2).split("\n").sort
  end

  def test_sign_exercise
    output = File.open('../test_data/sol_sign.txt').read
    assert_equal output.split("\n").sort, Rosalind.sign(4).split("\n").sort
  end

  def test_lgis_basic
    skip
    inputo = "9\n8 2 1 6 5 7 4 3 9"
    output = "2 6 7 9\n8 6 5 4 3"
    assert_equal output, Rosalind.lgis(inputo)
  end

  def test_lgis_exercise
    skip
    inputo = File.open('../test_data/rosalind_lgis.txt').read
    output = File.open('../test_data/sol_lgis.txt').read
    Rosalind.lgis(inputo)
    # assert_equal output, Rosalind.lgis(inputo)
  end

  def test_sseq_basic
    inputo = ">Rosalind_14\nACGTACGTGACG\n>Rosalind_18\nGTA"
    assert_equal "3 4 5", Rosalind.sseq(inputo)
  end

  def test_sseq_partial_find
    skip
    inputo = ">Rosalind_14\nACGTCGTGCG\n>Rosalind_18\nGTA"
    refute Rosalind.sseq(inputo)
  end

  def test_sseq_no_find
    skip
    inputo = ">Rosalind_14\nACCCCCCCCC\n>Rosalind_18\nGTA"
    refute Rosalind.sseq(inputo)
  end

  def test_sseq_exercise
    inputo = File.open('../test_data/rosalind_sseq.txt').read
    output = File.open('../test_data/sol_sseq.txt').read.strip
    assert_equal output, Rosalind.sseq(inputo)
  end

  def test_common_concat
    skip
    assert_equal ["caracola", "carac"], Rosalind.common_concat("caracola", "carac")
    assert_equal ["AGACCTGCCGGAA", "CCTGCCGGAA"], Rosalind.common_concat("AGACCTGCCG", "CCTGCCGGAA")
    assert_equal ["caracolacao", "colacao"], Rosalind.common_concat("caracola", "colacao")
    assert_equal ["caracolacacao", "cacao"], Rosalind.common_concat("caracola", "cacao")
    assert_equal ["caracolaxxxxxxxxxxcacao", "xxxxxxxxxxcacao"], Rosalind.common_concat("caracola", "xxxxxxxxxxcacao")
    assert_equal ["cacaracola", "caracola"], Rosalind.common_concat("caracola", "cacara")
  end

  def test_long_comparison
    assert_equal "AGACCTGCCGGAA", Rosalind.velcro("AGACCTGCCG", "CCTGCCGGAA")
    assert_equal "AGACCTGCCGGAA", Rosalind.velcro("CCTGCCGGAA", "AGACCTGCCG")
    assert_equal "ATTAGACCTGCCGGAATAC", Rosalind.velcro("AGACCTGCCGGAATAC", "ATTAGACCTG")
    refute Rosalind.velcro("AGACCTGCCG", "TTTTTCGGAA")
  end

  def test_long_basic
    inputo = ">Rosalind_56\nATTAGACCTG\n>Rosalind_57\nCCTGCCGGAA\n>Rosalind_58\nAGACCTGCCG\n>Rosalind_59\nGCCGGAATAC"
    assert_equal "ATTAGACCTGCCGGAATAC", Rosalind.long(inputo)
  end

  def test_long_exercise
    inputo = File.open('../test_data/rosalind_long.txt').read
    output = File.open('../test_data/sol_long.txt').read.strip
    assert_equal output, Rosalind.long(inputo)
  end

  def test_inod_basic
    assert_equal 6, Rosalind.inod(8)
    assert_equal 4, Rosalind.inod(6)
    assert_equal 2, Rosalind.inod(4)
  end

  def test_sset_basic
    assert_equal 8, Rosalind.sset(3)
    assert_equal 639424, Rosalind.sset(970)
  end

  def test_seto_basic
    inputo = "10\n{1, 2, 3, 4, 5}\n{2, 8, 5, 10}"
    output = "{1, 2, 3, 4, 5, 8, 10}\n{2, 5}\n{1, 3, 4}\n{8, 10}\n{6, 7, 8, 9, 10}\n{1, 3, 4, 6, 7, 9}"
    assert_equal output, Rosalind.seto(inputo)
  end

  def test_seto_exercise
    inputo = File.open('../test_data/rosalind_seto.txt').read
    output = File.open('../test_data/sol_seto.txt').read.strip
    assert_equal output, Rosalind.seto(inputo)
  end

  def test_pdst_distance
    assert_equal 0.4, Rosalind.pdist("TTTCCATTTA", "GATTCATTTC")
  end

  def test_pdst_basic
    inputo = ">Rosalind_9499\nTTTCCATTTA\n>Rosalind_0942\nGATTCATTTC\n>Rosalind_6568\nTTTCCATTTT\n>Rosalind_1833\nGTTCCATTTA"
    output = "0.0 0.4 0.1 0.1\n0.4 0.0 0.4 0.3\n0.1 0.4 0.0 0.2\n0.1 0.3 0.2 0.0"
    assert_equal output, Rosalind.pdst(inputo)
  end

  def test_pdst_exercise
    inputo = File.open('../test_data/rosalind_pdst.txt').read
    output = File.open('../test_data/sol_pdst.txt').read.strip
    assert_equal output, Rosalind.pdst(inputo)
  end

  def test_rstr_basic
    inputo = "90000 0.6\nATAGCCGA"
    assert_equal 0.689, Rosalind.rstr(inputo)
  end

  def test_rstr_exercise
    inputo = File.open('../test_data/rosalind_rstr.txt').read
    assert_equal 0.2818469323229993, Rosalind.rstr(inputo)
  end

  def test_kmp_basic
    inputo = ">Rosalind_87\nCAGCATGGTATCACAGCAGAG"
    assert_equal "0 0 0 1 2 0 0 0 0 0 0 1 2 1 2 3 4 5 3 0 0", Rosalind.kmp(inputo)
  end

  def test_kmp_exercise
    inputo = File.open('../test_data/rosalind_kmp.txt').read
    output = File.open('../test_data/sol_kmp.txt').read
    assert_equal output, Rosalind.kmp(inputo)
  end

  def test_corr_basic
    inputo = ">Rosalind_52\nTCATC\n>Rosalind_44\nTTCAT\n>Rosalind_68\nTCATC\n>Rosalind_28\nTGAAA\n>Rosalind_95\nGAGGA\n>Rosalind_66\nTTTCA\n>Rosalind_33\nATCAA\n>Rosalind_21\nTTGAT\n>Rosalind_18\nTTTCC"
    assert_equal "TTCAT->TTGAT\nGAGGA->GATGA\nTTTCC->TTTCA", Rosalind.corr(inputo)
  end

  def test_corr_exercise
    inputo = File.open('../test_data/rosalind_corr.txt').read
    output = File.open('../test_data/sol_corr.txt').read
    assert_equal output, Rosalind.corr(inputo)
  end

end
