class Player < PlayerAbstract
  def ask_user_for_name
    print 'Your name: '
    self.name = gets.chomp
  end

  def choise
    loop do
      puts players_hands_and_scores
      puts choise_options
      user_choise = ask_user_for_choise
      return user_choise if user_choise
      puts 'Incorrect choise'
    end
  end

  private

  attr_accessor :name

  def players_hands_and_scores
    "#{hand_and_score}\n" \
    'Dealer hand: ***'
  end

  def choise_options
    "Your options:\n" \
    "1 - show cards\n" \
    '2 - skip' +
      if hand_size < cards_count_limit
        "\n3 - take card"
      else
        ''
      end
  end

  def ask_user_for_choise
    print 'Your choise: '
    choise_id = gets.to_i
    case choise_id
    when 1 then return :show_cards
    when 2 then return :skip
    when 3 then return :take_card if hand_size < cards_count_limit
    end
    nil
  end
end
