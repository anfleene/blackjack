require 'card'
class Player
  attr_accessor :cards, :name, :money, :bet
  
  def initialize(name=nil)
    @name = name
  end
  
end