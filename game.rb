require_relative 'desk'
require_relative 'card'

class Game
  attr_reader :player_money, :dealer_money, :player_hand, :dealer_hand, :bank

  def initialize
    @player_money = 100
    @dealer_money = 100
    @player_hand = nil
    @dealer_hand = nil
    @bank = 0
  end

  def over?
    round_finished? && (player_money < bet_size || dealer_money < bet_size)
  end

  def start_new_round
    self.player_money -= bet_size
    self.dealer_money -= bet_size
    self.bank = bet_size * 2
    self.desk = Desk.new
    self.player_hand = desk.give_cards(2)
    self.dealer_hand = desk.give_cards(2)
    self.player_moved = nil
    self.dealer_moved = nil
    self.whos_turn = :player
    self.round_finished_flag = false
  end

  def can_player_take_card?
    player_hand.size < hand_size_limit
  end

  def player_score
    score(player_hand)
  end

  def dealer_score
    score(dealer_hand)
  end

  def player_move=(move)
    player_move!(move)
  end

  def round_finished?
    round_finished_flag
  end

  def dealer_move
    dealer_moved
  end

  def winner
    return unless round_finished?
    player_score_final = player_score > 21 ? -player_score : player_score
    dealer_score_final = dealer_score > 21 ? -dealer_score : dealer_score
    return :player if player_score_final > dealer_score_final
    return :dealer if dealer_score_final > player_score_final
    :draw
  end

  private

  BET_SIZE = 10
  HAND_SIZE_LIMIT = 3

  attr_writer :player_money, :dealer_money, :player_hand, :dealer_hand, :bank
  attr_accessor :round_finished_flag, :whos_turn, :player_moved, :dealer_moved
  attr_accessor :desk

  def bet_size
    BET_SIZE
  end

  def hand_size_limit
    HAND_SIZE_LIMIT
  end

  def score(hand)
    result = 0
    aces = 0
    hand.each do |card|
      result += card_score(card)
      aces += 1 if card.ace?
    end
    result += 10 if result <= 11 && aces > 0
    result
  end

  def card_score(card)
    case card.rank
    when card.jack, card.queen, card.king then 10
    when card.ace then 1
    else card.rank
    end
  end

  def player_move!(move)
    return unless whos_turn == :player
    self.dealer_moved = nil
    self.player_moved = move
    take_card(player_hand) if player_moved == :take_card
    check_if_round_should_be_finished
    self.whos_turn = :dealer unless round_finished?
    dealer_move!
  end

  def dealer_move!
    return unless whos_turn == :dealer
    self.player_moved = nil
    self.dealer_moved = dealer_ai
    take_card(dealer_hand) if dealer_moved == :take_card
    check_if_round_should_be_finished
    self.whos_turn = :player unless round_finished?
  end

  def dealer_ai
    return :take_card if dealer_hand.size < hand_size_limit && dealer_score < 17
    :skip
  end

  def take_card(hand)
    hand.push(*desk.give_card)
  end

  def check_if_round_should_be_finished
    finish_round if player_moved == :show_cards
    finish_round if !can_player_take_card? && !can_dealer_take_card?
  end

  def can_dealer_take_card?
    dealer_hand.size < hand_size_limit
  end

  def finish_round
    self.round_finished_flag = true
    case winner
    when :player then self.player_money += bank
    when :dealer then self.dealer_money += bank
    when :draw
      self.player_money += bank / 2
      self.dealer_money += bank / 2
    end
    self.bank = 0
  end
end
