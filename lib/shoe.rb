require 'lib/deck'
class Shoe < Deck
  #a black jack shoe is usally 6 decks but can be set to any number
  def initialize(num_deck=6)
    @cards = []
    #build the number of decks passed
    num_deck.times do
      @cards += self.build_deck
    end
    #shuffle all the cards
    self.shuffle!
  end
  
  #return true if there is less than one deck left
  def re_shuffle?
    self.size < Deck.size
  end
end