require_relative 'interface'
require_relative 'game'
require_relative 'player_abstract'
require_relative 'player'
require_relative 'dealer'
require_relative 'desk'
require_relative 'card'

class Main
  def initialize
    @interface = Interface.new
  end

  def start
    interface.start
  end

  private

  attr_reader :interface
end

Main.new.start
