require_relative 'player_abstract'
require_relative 'player'
require_relative 'dealer'
require_relative 'desk'
require_relative 'card'

class Main
  MONEY_START = 100
  MONEY_BET = 10
  CARDS_COUNT_START = 2
  CARDS_COUNT_END = 3

  def initialize
    @player = Player.new(MONEY_START, CARDS_COUNT_END)
    @dealer = Dealer.new(MONEY_START, CARDS_COUNT_END)
    @desk = Desk.new
    @bank = 0
    @keep_play_flag = true
    @new_game_flag = true
  end

  def play
    print "\nWelcome to the BlackJack game!\n\n"
    player.ask_user_for_name
    while keep_play_flag
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
    puts '================= New game ================='
    fill_bank
    desk.new_desk
    desk.shuffle
    player.take_cards(desk.give_cards(CARDS_COUNT_START))
    dealer.take_cards(desk.give_cards(CARDS_COUNT_START))
    self.new_game_flag = false
  end

  def fill_bank
    self.bank = bank + player.give_money(MONEY_BET)
    self.bank = bank + dealer.give_money(MONEY_BET)
    puts player_money_and_bank
  end

  def move(player)
    puts "=== #{player.class} move ==="
    case player.choise
    when :skip then do_nothing
    when :take_card then player.take_cards(desk.give_cards(1))
    when :show_cards then show_cards_and_choose_winner
    end
  end

  def maximum_hands_sizes
    player.hand_size == CARDS_COUNT_END && dealer.hand_size == CARDS_COUNT_END
  end

  def do_nothing; end

  def show_cards_and_choose_winner
    puts hands_and_scores
    case choose_winner
    when :player then win(player)
    when :dealer then win(dealer)
    when :draw then draw
    end
    clear_bank_and_hands
    puts '================= Game end ================='
    self.new_game_flag = true
    self.keep_play_flag = ask_user_to_play_again
  end

  def hands_and_scores
    "=== Showing cards ===\n" \
    "#{player.hand_and_score}\n" \
    "#{dealer.hand_and_score}"
  end

  def choose_winner
    player_score = player.score
    dealer_score = dealer.score
    player_score = 0 - player_score if player_score > 21
    dealer_score = 0 - dealer_score if dealer_score > 21
    return :player if player_score > dealer_score
    return :dealer if dealer_score > player_score
    :draw
  end

  def win(player)
    puts "#{player.class} win"
    player.win(bank)
    puts players_money
  end

  def draw
    puts 'Draw'
    player.win(bank / 2)
    dealer.win(bank / 2)
    puts players_money
  end

  def players_money
    "Player: #{player.money}, Dealer: #{dealer.money}"
  end

  def player_money_and_bank
    "#{players_money}, Bank: #{bank}"
  end

  def clear_bank_and_hands
    self.bank = 0
    player.drop_hand
    dealer.drop_hand
  end

  def ask_user_to_play_again
    loop do
      puts options_for_new_game
      user_choise = gets.to_i
      case user_choise
      when 1
        reset_money if player.money < MONEY_BET || dealer.money < MONEY_BET
        return true
      when 0 then return false
      end
    end
  end

  def options_for_new_game
    if player.money < MONEY_BET
      "You don't have enough money to play new game.\n" \
      'Do you want to start over? (1 - yes, 0 - no)'
    elsif dealer.money < MONEY_BET
      "Dealer don't have enough money to play new game.\n" \
      'Do you want to start over? (1 - yes, 0 - no)'
    else
      'Do you want to play again? (1 - yes, 0 - no)'
    end
  end

  def reset_money
    player.reset_money(MONEY_START)
    dealer.reset_money(MONEY_START)
  end
end

Main.new.play
