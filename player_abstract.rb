class PlayerAbstract
  def initialize(money)
    @money = money
    @hand = []
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
  def win(money)
  def drop_hand

  private

  attr_accessor :money
  attr_reader :hand
end