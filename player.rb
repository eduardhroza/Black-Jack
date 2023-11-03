# rubocop:disable Metrics/MethodLength
# frozen_string_literal: true

class Player
  attr_reader :name, :hand
  attr_accessor :bank

  def initialize(name, bank_amount)
    @name = name
    @hand = []
    @bank = bank_amount
  end

  def take_card(deck)
    deck.rebuild_deck if deck.empty?
    @hand << deck.deal_card
  end

  def bet(amount)
    raise 'Not enough credit for bet.' unless amount <= @bank

    @bank -= amount
    amount
  end

  def points
    total = 0
    aces = 0

    @hand.each do |card|
      if card.rank == 'A'
        aces += 1
      else
        total += card.value
      end
    end

    aces.times do
      total += total + 11 <= 21 ? 11 : 1
    end

    total
  end

  def hit?
    points < 17
  end

  def show_hand
    hand_string = @hand.map(&:to_s).join(', ')
    "#{@name}'s hand: [#{hand_string}] - Points: #{points}"
  end

  def show_bank
    "#{@name}'s bank: $#{@bank}"
  end
end

# rubocop:enable Metrics/MethodLength
