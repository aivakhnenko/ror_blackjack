class PlayerAbstract
  attr_reader :money

  def initialize(money, cards_count_limit)
    @money = money
    @hand = []
    @cards_count_limit = cards_count_limit
  end

  def give_money(money)
    raise ErrorNoMoney if money > self.money
    self.money -= money
    money
  end

  def take_cards(cards)
    hand.push(*cards)
  end

  def hand_and_score
    "#{self.class} hand: #{hand_to_s}, score: #{score}"
  end

  def hand_to_s
    hand.join(' ')
  end

  def score
    result = 0
    aces = 0
    hand.each do |card|
      result += card_score(card)
      aces += 1 if card.ace?
    end
    result += 10 if result <= 11 && aces > 0
    result
  end

  def card_score(card)
    case card.rank
    when 11, 12, 13 then 10
    when 14 then 1
    else card.rank
    end
  end

  def hand_size
    hand.size
  end

  def win(money)
    self.money += money
  end

  def drop_hand
    hand.clear
  end

  def reset_money(money)
    self.money = money
  end

  private

  attr_writer :money
  attr_reader :hand, :cards_count_limit
end
