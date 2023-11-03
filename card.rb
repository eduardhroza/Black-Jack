# frozen_string_literal: true

class Card
  SUITS = ['♥', '♦', '♠', '♣'].freeze
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def value
    return 10 if %w[J Q K].include?(@rank)
    return [1, 11] if @rank == 'A'  # Ace can be 1 or 11.

    @rank.to_i
  end

  def to_s
    "#{@rank}#{@suit}"
  end
end
