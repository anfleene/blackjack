require 'lib/card'
require 'lib/randomizer'
class Deck
  #default deck size is 52
  def self.size
    52
  end
  #a deck contains cards
  attr_accessor :cards
  def initialize
    @cards = build_deck
  end

  #build a standard deck of cards  
  def build_deck
    0.upto(51).map{ |i| Card.new(i)}
  end
  
  #randomizes the order of the deck
  def shuffle!
    @cards.randomize!
  end
  
  #returns a randomized version but doesn't actually randomize the actual deck
  def shuffle
   @cards.randomize
  end 

  #pops the next card off the deck
  def next_card!
    @cards.pop
  end

  #returns the next card but doesn't pop it
  def next_card
    @cards.last
  end
  
  #returns the next card but doesn't pop it
  def size
    @cards.size
  end
end