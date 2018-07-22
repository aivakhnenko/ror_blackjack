class PlayerAbstract
  def initialize(money, cards_count_limit)
    @money = money
    @hand = []
    @cards_count_limit = cards_count_limit
  end

  def give_money(money)
    if self.money >= money
      self.money -= money
      money
    else
      raise ErrorNoMoney
    end
  end

  def take_cards(cards)
    hand << cards
  end

  def show_hand
    hand.join(' ')
  end

  def score
    result = 0
    aces = 0
    hand.each do |card|
      result += card.score
      aces += 1 if card.ace?
    end
    result += 10 if result <= 11 && aces > 0
  end

  def hand_size
    hand.size
  end

  def win(money)
    self.money += money
  end

  def drop_hand

  private

  attr_accessor :money
  attr_reader :hand
  attr_reader :cards_count_limit
end
