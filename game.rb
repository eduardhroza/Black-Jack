# rubocop:disable Layout/EndOfLine
# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'card'

class Game
  attr_reader :player, :dealer, :deck, :name

  def initialize
    @deck = Deck.new
    begin
      puts 'Welcome to Blackjack! Please enter your name:'
      @name = gets.chomp
      validate!
    rescue RuntimeError => e
      puts e.message
      retry
    end
    @player = Player.new(@name, 100)
    @dealer = Dealer.new(100)
  end

  def start
    loop do
      setup_round
      player_turn
      dealer_turn if player.points <= 21
      show_final_result
      break unless play_again?

      reset_round
    end
    puts "Thank you for playing, #{player.name}!"
  end

  private

  def validate!
    raise 'Name cannot be empty. Please enter your name.' if @name.strip.empty?
  end

  def setup_round
    2.times { player.take_card(deck) }
    2.times { dealer.take_card(deck) }
    bet
    show_hands
  end

  def player_turn # rubocop:disable Metrics/AbcSize
    puts "Your turn, #{player.name}!"
    choice = nil
    until choice == 'stand' || player.hand.size == 3
      puts 'Would you like to (hit), (stand), or (show)?'
      choice = gets.chomp.downcase
      case choice
      when 'hit'
        player.take_card(deck) if player.hand.size == 2
        show_hands
      when 'show'
        break
      end
    end
  end

  def dealer_turn
    puts "Dealer's turn..."
    dealer.take_card(deck) if dealer.points < 17 && dealer.hand.size == 2
  end

  def show_hands
    puts "#{player.name}'s hand: #{player.show_hand}"
    puts "Dealer's hand: #{dealer.show_hand}"
  end

  def show_final_result # rubocop:disable Metrics/AbcSize
    if player.points > 21
      puts "#{player.name} busts! Dealer wins."
      dealer.bank += 20
    elsif dealer.points > 21 || player.points > dealer.points
      puts "#{player.name} wins!"
      player.bank += 20
    elsif player.points < dealer.points
      puts 'Dealer wins!'
      dealer.bank += 20
    else
      puts "It's a tie!"
      player.bank += 10
      dealer.bank += 10
    end
  end

  def bet
    player.bet(10)
    dealer.bet(10)
  end

  def play_again?
    puts 'Do you want to play again? (yes/no)'
    answer = gets.chomp.downcase
    answer == 'yes'
  end

  def reset_round
    @deck = Deck.new
    player.hand.clear
    dealer.hand.clear
  end
end

game = Game.new
game.start
# rubocop:enable Metrics/MethodLength, Layout/EndOfLine
