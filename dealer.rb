require 'player'
class Dealer < Player
  def initialize(name=nil)
    super(name)
  end
  
  def rank
    self.hand.rank
  end
  
  def collect
    @hands = []
  end
  
  def busted?
    self.hand.busted?
  end
  
  def take_turn
    while self.hand.rank < 17
      puts self.to_s(false)
      puts "Hitting...\n\n"
      2.times{ sleep 1 }
      self.hand.hit
    end
    puts self.to_s(false)
  end
  
  def hand
    @hands.first
  end
  
  def cards_to_s(hide_first)
    cards = hide_first ? self.hand.cards[1..-1] : self.hand.cards
    string = "-------------------------\n"
    cards.each do |card|
      string << card.to_s
      string << "\n"
    end
    string << "-------------------------\n\n"
  end
  
  def to_s(hide_first=true)
    string = "Dealer's Hand: \n"
    string << cards_to_s(hide_first)
  end
end