class Main
  MONEY_START = 100
  MONEY_BET = 10
  CARDS_COUNT_START = 2
  CARDS_COUNT_END = 3

  def initialize
    @player = Player.new(MONEY_START)
    player.ask_user_for_name
    @dealer = Dealer.new(MONEY_START)
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
end

class PlayerAbstract
  def initialize(money)
    @money = money
    @hand = []
  end

  def give_money(money)
    if self.money >= money
      self.money -= money
      money
    else
      raise ErrorNoMoney
    end
  end

  def take_cards(cards)
    hand << cards
  end

  def show_hand
    hand.join(' ')
  end

  def score
  def win(money)
  def drop_hand

  private

  attr_accessor :money
  attr_reader :hand
end

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

  def hand_size

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
    puts '3 - take cards' if hand.size < CARDS_COUNT_END
  end

  def ask_user_for_choise
    print 'Your choise: '
    choise_id = gets.to_i
    case choise_id
    when 1 then return :show_cards
    when 2 then return :skip
    when 3 then return :take_card if hand.size <CARDS_COUNT_END
    end
    nil
  end

  attr_accessor :name
end

class Dealer < PlayerAbstract
  def choise
  def hand_size
end

class Desk
  def initialize
    @cards = []
  end

  def new_desk
    self.cards = []
    [1..4].each do |suit|
      [2..14].each do |rank|
        cards << Card.new(suit, rank)
      end
    end
  end

  def shuffle
    cards.shuffle!
  end

  def give_cards(cards_count)
    giving_cards = cards[0, cards_count]
    self.cards = cards.drop(cards_count)
    giving_cards
  end

  private

  attr_accessor :cards
end

class Card
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{show_rank}#{show_suit}"
  end

  private

  attr_reader :suit, :rank

  def show_suit
    case suit
    when 1 then "\u2660"
    when 2 then "\u2665"
    when 3 then "\u2666"
    when 4 then "\u2663"
    end
  end

  def show_rank
    case rank
    when 11 then 'J'
    when 12 then 'Q'
    when 13 then 'K'
    when 14 then 'A'
    else rank.to_s
    end
  end
end

Main.new.play
