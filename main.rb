player_name = ask_player_name
player = Player.new(100, player_name)
dealer = Dealer.new(100)
desk = Desk.new(52)
MONEY_STACK = 10
keep_play_flag = true
new_game_flag = true
while keep_play_flag do
  if new_game_flag
    bank += player.get_money(MONEY_STACK)
    bank += dealer.get_money(MONEY_STACK)
    desk.get_new_desk.shuffle
    player.get_cards(desk.get_cards(2))
    dealer.get_cards(desk.get_cards(2))
    new_game_flag = false
  end
  player_choise = player.make_choise
  case player_choise
  when :skip
    do_nothing
  when :get_card
    player.get_cards(desk.get_cards(1))
  when :show_cards
    show_cards_and_choose_winner
    new_game_flag = true
  end
  next while if new_game_flag
  dealer_choise = dealer.make_choise
  case dealer_choise
  when :skip
    do_nothing
  when :get_card
    dealer.get_cards(desk.get_cards(1))
  end
  if player.hand_size == 3 && dealer.hand_size == 3
    show_cards_and_choose_winner
  end
  keep_play_flag = ask_aser_to_play_again
end
