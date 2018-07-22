class Player < PlayerAbstract
  def ask_user_for_name
    print 'Your name: '
    self.name = gets.chomp
  end

  def choise
    loop
      show_info
      show_choise_options
      user_choise = ask_user_for_choise
      return user_choise if user_choise
    end
  end

  private

  def show_info
    puts 'Your hand: #{show_hand}'
    puts 'Dealer hand: ***'
    puts 'Your score: #{score}'
  end

  def show_choise_options
    puts 'Your options:'
    puts '1 - show cards'
    puts '2 - skip'
    puts '3 - take cards' if hand_size < CARDS_COUNT_END
  end

  def ask_user_for_choise
    print 'Your choise: '
    choise_id = gets.to_i
    case choise_id
    when 1 then return :show_cards
    when 2 then return :skip
    when 3 then return :take_card if hand_size <CARDS_COUNT_END
    end
    nil
  end

  attr_accessor :name
end
