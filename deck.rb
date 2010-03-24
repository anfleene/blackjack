require 'card'
require 'randomizer'
class Deck
  
  def self.size
    52
  end
  attr_accessor :cards
  def initialize
    @cards = build_deck
  end
  
  def build_deck
    0.upto(51).map{ |i| Card.new(i)}
  end
  
  def shuffle!
    @cards.randomize!
  end
  
  def shuffle
   @cards.randomize
  end 
  
  def next_card!
    @cards.pop
  end
  
  def next_card
    @cards.last
  end
  
  def size
    @cards.size
  end
end