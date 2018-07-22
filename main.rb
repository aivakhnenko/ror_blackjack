class Main
  MONEY_START = 100
  MONEY_BET = 10
  CARDS_COUNT_START = 2
  CARDS_COUNT_END = 3

  def initialize
    @player = Player.new(MONEY_START, CARDS_COUNT_END)
    player.ask_user_for_name
    @dealer = Dealer.new(MONEY_START, CARDS_COUNT_END)
    @desk = Desk.new
    @bank = 0
    @keep_play_flag = true
    @new_game_flag = true
  end

  def play
    puts 'Start'
    while keep_play_flag do
      new_game_preparation if new_game_flag
      move(player)
      next if new_game_flag
      move(dealer)
      show_cards_and_choose_winner if maximum_hands_sizes
    end
  end

  private

  attr_reader :player, :dealer, :desk
  attr_accessor :bank, :keep_play_flag, :new_game_flag

  def new_game_preparation
    bank += player.give_money(MONEY_BET)
    bank += dealer.give_money(MONEY_BET)
    desk.new_desk.shuffle
    player.take_cards(desk.give_cards(CARDS_COUNT_START))
    dealer.take_cards(desk.give_cards(CARDS_COUNT_START))
    self.new_game_flag = false
  end

  def move(player)
    case player.choise
    when :skip then do_nothing
    when :take_card then player.take_cards(desk.give_cards(1))
    when :show_cards then show_cards_and_choose_winner
    end
  end

  def maximum_hands_sizes
    player.hand_size == CARDS_COUNT_END &&
    dealer.hand_size == CARDS_COUNT_END
  end

  def do_nothing; end

  def show_cards_and_choose_winner
    show_cards_and_scores
    case choose_winner
    when :player then win(player)
    when :dealer then win(dealer)
    when :draw then draw
    end
    clear_bank_and_hands
    self.keep_play_flag = ask_user_to_play_again
  end

  def show_cards_and_scores
    puts 'Showing cards:'
    puts 'Player: cards: #{player.show_hand}, score: #{player.score}'
    puts 'Dealer: cards: #{dealer.show_hand}, score: #{dealer.score}'
  end

  def choose_winner
    player_score = player.score
    dealer_score = dealer.score
    player_score = 0 - player_score if player_score > 21
    dealer_score = 0 - dealer_score if player_score > 21
    return :player if player_score > dealer_score
    return :dealer if dealer_score > player_score
    return :draw
  end

  def win(player)
    puts "#{player.class} win"
    player.win(bank)
  end

  def draw
    puts 'Draw'
    player.win(bank / 2)
    dealer.win(bank / 2)
  end

  def clear_bank_and_hands
    self.bank = 0
    player.drop_hand
    dealer.drop_hand
  end

  def ask_user_to_play_again
    loop
      show_options_for_new_game
      user_choise = gets.to_i
      case user_choise
      when 1
        if player.money < MONEY_BET || dealer.money < MONEY_BET
          player.reset_money(MONEY_START)
          dealer.reset_money(MONEY_START)
        end
        return true
      when 0 then return false
    end
  end

  def show_options_for_new_game
    if player.money < MONEY_BET
      puts "You don't have enough money to play new game."
      puts 'Do you want to start over? (1 - yes, 0 - no)'
    elsif dealer_score < MONEY_BET
      puts "Dealer don't have enough money to play new game."
      puts 'Do you want to start over? (1 - yes, 0 - no)'
    else
      puts 'Do you want to play again? (1 - yes, 0 - no)'
    end
  end
end

Main.new.play
