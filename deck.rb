# frozen_string_literal: true

require_relative 'card'

class Deck
  SUITS = Card::SUITS
  RANKS = Card::RANKS

  def initialize
    @cards = build_deck
    shuffle!
  end

  def deal_card
    refill_deck if empty?
    @cards.pop
  end

  def empty?
    @cards.empty?
  end

  private

  def build_deck
    SUITS.product(RANKS).map { |suit, rank| Card.new(suit, rank) }
  end

  def rebuild_deck
    @cards = build_deck
    shuffle!
  end

  def refill_deck
    @cards = build_deck
    shuffle!
  end

  def shuffle!
    @cards.shuffle!
  end
end
