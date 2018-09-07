class Desk
  def initialize
    @cards = []
    (1..4).each do |suit|
      (2..14).each do |rank|
        cards << Card.new(suit, rank)
      end
    end
    cards.shuffle!
  end

  def give_cards(cards_count)
    giving_cards = cards[0, cards_count]
    self.cards = cards.drop(cards_count)
    giving_cards
  end

  def give_card
    give_cards(1)
  end

  private

  attr_accessor :cards
end
