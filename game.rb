class Game
  MONEY_START = 100
  MONEY_BET = 10
  CARDS_COUNT_START = 2
  CARDS_COUNT_END = 3

  attr_reader :bank, :new_game_flag
  attr_accessor :keep_play_flag

  def initialize
    @player = Player.new(self, MONEY_START, CARDS_COUNT_END)
    @dealer = Dealer.new(self, MONEY_START, CARDS_COUNT_END)
    @desk = Desk.new
    @bank = 0
    @keep_play_flag = true
    @new_game_flag = true
  end

  def player_name=(player_name)
    player.name = player_name
  end

  def new_game_preparation
    new_desk
    desk_shuffle
    player_take_initial_cards
    dealer_take_initial_cards
    fill_bank
    self.new_game_flag = false
  end

  def player_hand
    player.hand
  end

  def player_score
    player.score
  end

  def dealer_hand
    dealer.hand
  end

  def dealer_score
    dealer.score
  end

  def player_hand_size
    player.hand_size
  end

  def cards_count_limit
    CARDS_COUNT_END
  end

  def player_take_card
    player.take_cards(desk.give_cards(1))
  end

  def dealer_take_card
    dealer.take_cards(desk.give_cards(1))
  end

  def choose_winner
    player_score_final = player_score <= 21 ? player_score : -player_score
    dealer_score_final = dealer_score <= 21 ? dealer_score : -dealer_score
    return :player if player_score_final > dealer_score_final
    return :dealer if dealer_score_final > player_score_final
    :draw
  end

  def player_win
    player.win(bank)
  end

  def dealer_win
    dealer.win(bank)
  end

  def draw
    player.win(bank / 2)
    dealer.win(bank / 2)
  end

  def clear_bank_and_hands
    self.bank = 0
    player.drop_hand
    dealer.drop_hand
    self.new_game_flag = true
  end

  def player_money
    player.money
  end

  def dealer_money
    dealer.money
  end

  def money_bet
    MONEY_BET
  end

  def reset_money
    player.reset_money(MONEY_START)
    dealer.reset_money(MONEY_START)
  end

  def maximum_hands_sizes?
    player.hand_size == CARDS_COUNT_END && dealer.hand_size == CARDS_COUNT_END
  end

  def dealer_choise
    dealer.choise
  end

  private

  attr_reader :player, :dealer, :desk
  attr_writer :bank, :new_game_flag

  def new_desk
    desk.new_desk
  end

  def desk_shuffle
    desk.shuffle
  end

  def player_take_initial_cards
    player.take_cards(desk.give_cards(CARDS_COUNT_START))
  end

  def dealer_take_initial_cards
    dealer.take_cards(desk.give_cards(CARDS_COUNT_START))
  end

  def fill_bank
    self.bank = bank + player.give_money(MONEY_BET)
    self.bank = bank + dealer.give_money(MONEY_BET)
  end
end
