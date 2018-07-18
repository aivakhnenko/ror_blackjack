class BlackJackGame
  attr_reader :players, :desk

  def initialize
    players = []
    players << { player: Player.new, interface: 
    players << Player.new
  end
end

class Player
end

class PlayerUserInterface
end

class DilerLogic
end

class Desk
  attr_reader :desk

  def initialize;
    desk = []
    refill!
  end

  def empty?; end
  def shuffle!; end
  def get_random_card; end
  def refill!
    [1..4].each do |suit|
      [1..13].each { |rank| desk << Card.new(suit, rank) }
    end
  end
end

class Card
  attr_reader :rank, :suit, :name

  def initialize; end
end
