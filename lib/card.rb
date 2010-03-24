class Card
  require 'lib/suit'
  require 'lib/rank'
  attr_accessor :suit, :rank, :number
  
  def initialize(rank, suit=nil)
    #if only one argument is passed its the card number
    if suit.nil?
      #set the number
      @number = rank
      #set the rank based off of the number of ranks
      @rank = Rank[rank % Rank.size]
      #set the suit based off of the number of suits      
      @suit = Suit[rank % Suit.size]
    else
      @suit = suit
      @rank = rank
      #calc the actual card number
      @number = (Rank.size * Suit[suit]) + Rank.index(rank)
    end
  end
  
  def rank_value
    #returns the actual value of the card
    Rank[rank]
  end

  #returns a pretty string of the card  
  def to_s
    "#{rank} of #{suit}"
  end
end