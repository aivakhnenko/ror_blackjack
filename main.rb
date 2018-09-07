require_relative 'interface'

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
