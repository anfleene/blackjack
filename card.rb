class Card
  require 'suit'
  require 'rank'
  attr_accessor :suit, :rank, :number
  
  def initialize(rank, suit=nil)
    if suit.nil?
      @number = rank
      @rank = Rank[rank % Rank.size]
      @suit = Suit[rank % Suit.size]
    else
      @suit = suit
      @rank = rank
      @number = (Rank.size * Suit[suit]) + Rank.index(rank)
    end
  end
  
  def rank_value
    Rank[rank]
  end
  
  def to_s
    "#{rank} of #{suit}"
  end
end