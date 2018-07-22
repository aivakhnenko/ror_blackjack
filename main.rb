class Main
  MONEY_TOTAL = 100
  MONEY_STACK = 10
  CARDS_COUNT_AT_START = 2
  CARDS_COUNT_AT_END = 3

  attr_reader :player_name
  attr_reader :player
  attr_reader :dealer
  attr_reader :desk
  attr_reader :keep_play_flag
  attr_accessor :new_game_flag
  attr_reader :bank

  def initialize
    @player_name = ask_player_name
    @player = Player.new(MONEY_TOTAL, player_name)
    @dealer = Dealer.new(MONEY_TOTAL)
    @desk = Desk.new
    @keep_play_flag = true
    @new_game_flag = true
    @bank = 0
  end

  def play
    puts 'Start'
    while keep_play_flag do
      new_game_preparation if new_game_flag
      player_move
      next if new_game_flag
      dealer_move
      show_cards_and_choose_winner if maximum_hands_sizes
    end
  end

  def ask_player_name
    print 'Your name: '
    gets.chomp
  end

  def new_game_preparation
    bank += player.give_money(MONEY_STACK)
    bank += dealer.give_money(MONEY_STACK)
    desk.new_desk.shuffle
    player.take_cards(desk.give_cards(CARDS_COUNT_AT_START))
    dealer.take_cards(desk.give_cards(CARDS_COUNT_AT_START))
    self.new_game_flag = false
  end

  def player_move
    case player.choise
    when :skip then do_nothing
    when :get_card then player.take_cards(desk.give_cards(1))
    when :show_cards then show_cards_and_choose_winner
    end
  end

  def dealer_move
    case dealer.choise
    when :skip then do_nothing
    when :get_card then dealer.take_cards(desk.give_cards(1))
    end
  end

  def maximum_hands_sizes
    player.hand_size == CARDS_COUNT_AT_END &&
    dealer.hand_size == CARDS_COUNT_AT_END
  end

  def do_nothing; end

  def show_cards_and_choose_winner
  def ask_user_to_play_again
end

class Player
  def initialize(money, name)
  def give_money(money)
  def take_cards(cards)
  def choise
  def hand_size
end

class Dealer
  def initialize(money)
  def give_money(money)
  def take_cards(cards)
  def choise
  def hand_size
end

class Desk
  def initialize
  def new_desk
  def shuffle
  def give_cards(cards_count)
end

Main.new.play
