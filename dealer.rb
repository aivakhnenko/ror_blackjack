class Dealer < PlayerAbstract
  def choise
    return :take_card if hand_size < cards_count_limit && score < 17
    return :skip
  end
end
