require_relative './revc'

require 'minitest/autorun'
require 'minitest/pride'

class Mendel
  attr_accessor :bag_o_cats

  ALLE = {black: 'FF', grey: 'Ff', white: 'ff'}
  DOMN = 'F'
  CARD = 2

  ## The experiment starts with a set number of colored cats in the bag.

  def initialize k, m, n
    @bag_o_cats = { black: k.to_f, grey: m.to_f, white: n.to_f}
  end

  ## How many cats are in the bag?

  def n_cats
    @bag_o_cats.values.reduce(0, :+)
  end

  ## Array of all possible combinations of cats in the bag.

  def all_possible_cat_pairs
    cat_types = @bag_o_cats.keys
    cat_types.product(cat_types)
  end

  ## Probability of blindly picking a cat from the bag of color a,
  #  and then, again blindly, picking a second cat of color b.

  def prob_selecting_cats_of_colors a, b
    p_first  = (@bag_o_cats[a] / n_cats)
    p_second = (a == b ? @bag_o_cats[b] - 1 : @bag_o_cats[b]) / (n_cats - 1)
    p_first * p_second
  end

  ## An allele is dominant if it has a Dominant one.

  def dominant? a
    a.include? DOMN
  end

  ## Probability of kitten with dominant phenotype (at least one F allele),
  #  given two parents of colors a and b.

  def prob_pheno_dominant_given_parent_colors a, b
    possible_combinations = ALLE[a].chars.product ALLE[b].chars
    possible_combinations.count{ |x| dominant? x }.to_f / (CARD * CARD)
  end

  ## Compute all possibilities and add all probabilities

  def law_1
    all_possible_cat_pairs.map do |a, b|
      prob_selecting_cats_of_colors(a, b) *
      prob_pheno_dominant_given_parent_colors(a, b)
    end.reduce(:+)
  end
end

class TestMendel < Minitest::Test
  def test_I_law
    assert_in_delta 0.78333, Mendel.new(2, 2, 2).law_1, 0.0001
    assert_in_delta 0.84731, Mendel.new(30, 20, 16).law_1, 0.0001
  end
end



# A hardcoded initial version
#
# class Mendel
#   Prob_dom_if_k = 1.0
#   Prob_dom_if_mm = 0.75
#   Prob_dom_if_mn = 0.5
#
#   def initialize(vars)
#     @k, @m, @n = vars.map &:to_f
#     @pop = vars.reduce(0, :+).to_f
#   end
#
#   def law1(n)
#     deno = @pop * (@pop - 1.0)
#
#     (@k * (@k - 1.0) * Prob_dom_if_k  / deno) +
#     (@k * @m         * Prob_dom_if_k  / deno) +
#     (@k * @n         * Prob_dom_if_k  / deno) +
#
#     (@m * @k         * Prob_dom_if_k  / deno) +
#     (@m * (@m - 1.0) * Prob_dom_if_mm / deno) +
#     (@m * @n         * Prob_dom_if_mn / deno) +
#
#     (@n * @k         * Prob_dom_if_k  / deno) +
#     (@n * @m         * Prob_dom_if_mn / deno)
#   end
# end

