# frozen_string_literal: true

class Dealer < Player
  def initialize(bank_amount = 100)
    super('Dealer', bank_amount)
  end

  def hit?
    points < 17
  end

  def show_hand
    if @hand.size > 1
      "Dealer's hand: [**hidden**]"
    else
      super
    end
  end
end
