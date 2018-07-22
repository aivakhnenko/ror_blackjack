class Card
  J = 11
  Q = 12
  K = 13
  A = 14

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{show_rank}#{show_suit}"
  end

  def score
    case rank
    when J, Q, K then 10
    when A then 1
    else rank
    end
  end

  def ace?
    rank == A
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
    when J then 'J'
    when Q then 'Q'
    when K then 'K'
    when A then 'A'
    else rank.to_s
    end
  end
end
