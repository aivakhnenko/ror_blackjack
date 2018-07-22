class Main
  MONEY_TOTAL = 100
  MONEY_STACK = 10
  CARDS_COUNT_AT_START = 2
  CARDS_COUNT_AT_END = 3

  def initialize
    @player = Player.new(MONEY_TOTAL)
    player.ask_user_for_name
    @dealer = Dealer.new(MONEY_TOTAL)
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
    bank += player.give_money(MONEY_STACK)
    bank += dealer.give_money(MONEY_STACK)
    desk.new_desk.shuffle
    player.take_cards(desk.give_cards(CARDS_COUNT_AT_START))
    dealer.take_cards(desk.give_cards(CARDS_COUNT_AT_START))
    self.new_game_flag = false
  end

  def move(player)
    case player.choise
    when :skip then do_nothing
    when :get_card then player.take_cards(desk.give_cards(1))
    when :show_cards then show_cards_and_choose_winner
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

class PlayerAbstract
  def initialize(money)
    @money = money
  end

  def give_money(money)
    if self.money >= money
      self.money -= money
      money
    else
      raise ErrorNoMoney
    end
  end

  private

  attr_accessor :money
end

class Player < PlayerAbstract
  def ask_user_for_name
    print 'Your name: '
    self.name = gets.chomp
  end

  def take_cards(cards)
  def choise
  def hand_size

  private

  attr_accessor :name
end

class Dealer < PlayerAbstract
  def take_cards(cards)
  def choise
  def hand_size
end

class Desk
  def initialize
    @cards = []
  end

  def new_desk
    @cards = []
    [1..4].each do |suit|
      [2..14].each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
  end

  def shuffle
  def give_cards(cards_count)

  private

  attr_reader :cards
end

class Card
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end
end

Main.new.play
