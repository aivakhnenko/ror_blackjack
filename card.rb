class Card
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{show_rank}#{show_suit}"
  end

  def score
    case rank
    when 11 then 10
    when 12 then 10
    when 13 then 10
    when 14 then 1
    else rank
    end
  end

  def ace?
    rank == 14
  end

  private

  attr_reader :suit, :rank

  def show_suit
    case suit
    when 1 then "\u2660"
    when 2 then "\u2665"
    when 3 then "\u2666"
    when 4 then "\u2663"
    end
  end

  def show_rank
    case rank
    when 11 then 'J'
    when 12 then 'Q'
    when 13 then 'K'
    when 14 then 'A'
    else rank.to_s
    end
  end
end
