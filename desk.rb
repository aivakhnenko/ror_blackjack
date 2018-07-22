class Desk
  def initialize
    @cards = []
  end

  def new_desk
    self.cards = []
    [1..4].each do |suit|
      [2..14].each do |rank|
        cards << Card.new(suit, rank)
      end
    end
  end

  def shuffle
    cards.shuffle!
  end

  def give_cards(cards_count)
    giving_cards = cards[0, cards_count]
    self.cards = cards.drop(cards_count)
    giving_cards
  end

  private

  attr_accessor :cards
end
