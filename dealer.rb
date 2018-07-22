class Dealer < PlayerAbstract
  def choise
    if hand_size < cards_count_limit && score < 17
      result = :take_card
      puts 'Dealer take card'
    else
      result = :skip
      puts 'Dealer skip'
    end
    result
  end
end
