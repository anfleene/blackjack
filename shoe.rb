require 'deck'
class Shoe < Deck
  def initialize(num_deck=6)
    @cards = []
    num_deck.times do
      @cards += self.build_deck
    end
    self.shuffle!
  end
end