class Card
  attr_reader :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{rank_to_s}#{suit_to_s}"
  end

  def jack
    11
  end

  def queen
    12
  end

  def king
    13
  end

  def ace
    14
  end

  def ace?
    rank == ace
  end

  private

  attr_reader :suit

  def suit_to_s
    case suit
    when 1 then "\u2660"
    when 2 then "\u2665"
    when 3 then "\u2666"
    when 4 then "\u2663"
    end
  end

  def rank_to_s
    case rank
    when jack then 'J'
    when queen then 'Q'
    when king then 'K'
    when ace then 'A'
    else rank.to_s
    end
  end
end
