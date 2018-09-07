require_relative 'game'

class Interface
  def initialize; end

  def start
    show_welcome_message
    ask_player_name
    self.exit_flag = false
    loop do
      play_game
      break if exit_flag
    end
  end

  private

  attr_accessor :exit_flag, :game

  def play_game
    self.game = Game.new
    loop do
      play_round
      break if exit_flag || game.over?
    end
  end

  def play_round
    game.start_new_round
    show_round_start_info
    loop do
      game.player_move = ask_player_for_move
      show_dealer_move if game.dealer_move
      break if game.round_finished?
    end
    show_round_end_info
    ask_player_to_keep_playing
  end

  def show_round_start_info
    puts '================= Round start ================='
    puts players_money_and_bank
  end

  def ask_player_for_move
    puts '=== Player turn ==='
    puts player_hand_and_score
    puts dealer_hand_and_score_hidden
    puts player_options
    move = player_choise
    case move
    when :skip then puts 'Player skip'
    when :take_card then puts 'Player take card'
    end
    move
  end

  def player_options
    "Your options:\n" \
    "1 - show cards\n" \
    '2 - skip' +
      if game.can_player_take_card?
        "\n3 - take card"
      else
        ''
      end
  end

  def player_choise
    loop do
      print 'Your choise: '
      case gets.to_i
      when 1 then return :show_cards
      when 2 then return :skip
      when 3 then return :take_card if game.can_player_take_card?
      end
      puts 'Incorrect choise'
    end
  end

  def show_dealer_move
    puts '=== Dealer turn ==='
    case game.dealer_move
    when :skip then puts 'Dealer skip'
    when :take_card then puts 'Dealer take card'
    end
  end

  def show_round_end_info
    puts '=== Showing cards ==='
    puts player_hand_and_score
    puts dealer_hand_and_score
    puts who_win
    puts players_money
    puts '================= Round end ==================='
  end

  def who_win
    case game.winner
    when :player then 'Player win'
    when :dealer then 'Dealer win'
    when :draw then 'Draw'
    end
  end

  def ask_player_to_keep_playing
    print 'Game over. ' if game.over?
    puts 'Do you want to play again? (1 - yes, 0 - no)'
    loop do
      print 'Your choise: '
      case gets.to_i
      when 1 then return
      when 0 then return self.exit_flag = true
      end
      puts 'Incorrect choise'
    end
  end

  def show_welcome_message
    print "\nWelcome to the BlackJack game!\n\n"
  end

  def ask_player_name
    print 'Your name: '
    gets
  end

  def players_money_and_bank
    "#{players_money}, Bank: #{game.bank}"
  end

  def players_money
    "Player: #{game.player_money}, Dealer: #{game.dealer_money}"
  end

  def player_hand_and_score
    "Player hand: #{player_hand}, score: #{game.player_score}"
  end

  def dealer_hand_and_score
    "Dealer hand: #{dealer_hand}, score: #{game.dealer_score}"
  end

  def player_hand
    game.player_hand.join(' ')
  end

  def dealer_hand
    game.dealer_hand.join(' ')
  end

  def dealer_hand_and_score_hidden
    'Dealer hand: ***, score: ***'
  end
end
