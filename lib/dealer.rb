require 'lib/player'
class Dealer < Player
  #call the parent construct(player)
  def initialize(name=nil)
    super(name)
  end

  #gets the rank of the dealer's hand  
  def rank
    self.hand.rank
  end
  
  #resets the dealers hand because they dont bet any money
  def collect
    @hands = []
  end
  
  #did the dealer bust
  def busted?
    self.hand.busted?
  end
  
  #hits until the hand is 17 or higher
  def take_turn
    while self.hand.rank < 17
      puts self.to_s(false)
      puts "Hitting...\n\n"
      2.times{ sleep 1 }
      self.hand.hit
    end
    puts self.to_s(false)
  end
  
  #returns the first hand because the dealer doesn't split
  def hand
    @hands.first
  end
  
  #a special print method that only shows the second card(like real blackjack)
  def cards_to_s(hide_first)
    cards = hide_first ? self.hand.cards[1..-1] : self.hand.cards
    string = "-------------------------\n"
    cards.each do |card|
      string << card.to_s
      string << "\n"
    end
    string << "-------------------------\n\n"
  end
  
  #special to_s that will hide the first card by default but print it if prompted
  def to_s(hide_first=true)
    string = "Dealer's Hand: \n"
    string << cards_to_s(hide_first)
  end
end