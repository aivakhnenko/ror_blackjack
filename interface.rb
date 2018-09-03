require_relative 'game'
require_relative 'player_abstract'
require_relative 'player'
require_relative 'dealer'
require_relative 'desk'
require_relative 'card'

class Interface
  def initialize
    @game = Game.new
  end

  def start
    welcome_message
    self.player_name = ask_player_name
    while keep_play_flag
      new_game if new_game_flag
      player_move
      next if new_game_flag
      dealer_move
      show_cards_and_choose_winner if maximum_hands_sizes?
    end
  end

  private

  attr_reader :game

  def welcome_message
    print "\nWelcome to the BlackJack game!\n\n"
  end

  def ask_player_name
    print 'Your name: '
    gets.chomp
  end

  def player_name=(player_name)
    game.player_name = player_name
  end

  def keep_play_flag
    game.keep_play_flag
  end

  def new_game_flag
    game.new_game_flag
  end

  def new_game
    puts '================= New game ================='
    new_game_preparation
    puts players_money_and_bank
  end

  def new_game_preparation
    game.new_game_preparation
  end

  def player_move
    puts '=== Player move ==='
    case player_choise
    when :skip then do_nothing
    when :take_card then player_take_card
    when :show_cards then show_cards_and_choose_winner
    end
  end

  def dealer_move
    puts '=== Dealer move ==='
    case dealer_choise
    when :skip then dealer_skip
    when :take_card then dealer_take_card
    when :show_cards then show_cards_and_choose_winner
    end
  end

  def dealer_choise
    game.dealer_choise
  end

  def show_cards_and_choose_winner
    puts hands_and_scores
    case choose_winner
    when :player then win_player
    when :dealer then win_dealer
    when :draw then draw
    end
    clear_bank_and_hands
    puts '================= Game end ================='
    self.keep_play_flag = ask_user_to_play_again
  end

  def keep_play_flag=(keep_play_flag)
    game.keep_play_flag = keep_play_flag
  end

  def ask_user_to_play_again
    loop do
      puts options_for_the_new_game
      user_choise = gets.to_i
      case user_choise
      when 1
        reset_money if player_money < money_bet || dealer_money < money_bet
        return true
      when 0 then return false
      end
    end
  end

  def options_for_the_new_game
    if player_money < money_bet
      "You don't have enough money to play new game.\n" \
      'Do you want to start over? (1 - yes, 0 - no)'
    elsif dealer_money < money_bet
      "Dealer don't have enough money to play new game.\n" \
      'Do you want to start over? (1 - yes, 0 - no)'
    else
      'Do you want to play again? (1 - yes, 0 - no)'
    end
  end

  def money_bet
    game.money_bet
  end

  def reset_money
    game.reset_money
  end

  def hands_and_scores
    "=== Showing cards ===\n" \
    "#{player_hand_and_score}\n" \
    "#{dealer_hand_and_score}"
  end

  def choose_winner
    game.choose_winner
  end

  def win_player
    puts 'Player win'
    player_win
    puts players_money
  end

  def win_dealer
    puts 'Dealer win'
    dealer_win
    puts players_money
  end

  def player_win
    game.player_win
  end

  def dealer_win
    game.dealer_win
  end

  def players_money_and_bank
    "#{players_money}, Bank: #{bank}"
  end

  def players_money
    "Player: #{player_money}, Dealer: #{dealer_money}"
  end

  def player_money
    game.player_money
  end

  def dealer_money
    game.dealer_money
  end

  def bank
    game.bank
  end

  def draw
    puts 'Draw'
    game.draw
    puts players_money
  end

  def clear_bank_and_hands
    game.clear_bank_and_hands
  end

  def player_take_card
    game.player_take_card
  end

  def dealer_take_card
    puts 'Dealer take card'
    game.dealer_take_card
  end

  def player_choise
    loop do
      puts players_hands_and_scores
      puts player_choise_options
      user_choise = ask_user_for_choise
      return user_choise if user_choise
      puts 'Incorrect choise'
    end
  end

  def dealer_skip
    puts 'Dealer skip'
    do_nothing
  end

  def do_nothing; end

  def players_hands_and_scores
    "#{player_hand_and_score}\n" \
    'Dealer hand: ***'
  end

  def player_hand_and_score
    "Player hand: #{player_hand_to_s}, score: #{player_score}"
  end

  def dealer_hand_and_score
    "Dealer hand: #{dealer_hand_to_s}, score: #{dealer_score}"
  end

  def player_hand_to_s
    player_hand.join(' ')
  end

  def player_hand
    game.player_hand
  end

  def player_score
    game.player_score
  end

  def dealer_hand_to_s
    dealer_hand.join(' ')
  end

  def dealer_hand
    game.dealer_hand
  end

  def dealer_score
    game.dealer_score
  end

  def player_choise_options
    "Your options:\n" \
    "1 - show cards\n" \
    '2 - skip' +
      if can_player_take_card?
        "\n3 - take card"
      else
        ''
      end
  end

  def can_player_take_card?
    player_hand_size < cards_count_limit
  end

  def player_hand_size
    game.player_hand_size
  end

  def cards_count_limit
    game.cards_count_limit
  end

  def ask_user_for_choise
    print 'Your choise: '
    choise_id = gets.to_i
    case choise_id
    when 1 then return :show_cards
    when 2 then return :skip
    when 3 then return :take_card if can_player_take_card?
    end
    nil
  end

  def maximum_hands_sizes?
    game.maximum_hands_sizes?
  end
end
