class Card
  require 'suit'
  require 'rank'
  attr_accessor :suit, :rank, :number
  
  def initialize(rank, suit=nil)
    if suit.nil?
      @number = rank
      @rank = rank % Rank.all.size
      @suit = rank % Suit.all.size
    else
      @suit = suit
      @rank = rank
      @number = (Rank.all.size * suit) + rank
    end
  end
  
  def rank_name
    Rank[rank].to_s
  end
    
    
  def suit_name
    Suit[suit].to_s
  end
  
  def to_s
    "#{Rank[rank]} of #{Suit[suit]}"
  end
end