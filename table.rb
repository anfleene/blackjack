require 'shoe'
require 'dealer'
class Table
  attr_accessor :shoe, :players, :dealer, :current_player
  def initialize
    @players = []
    @shoe = Shoe.new
    @dealer = Dealer.new("Dealer")
  end
  
  def deal(num_cards=2)
    @shoe = Shoe.new if @shoe.re_shuffle?
    @players.each{|player| player.deal(num_cards)}
    @dealer.deal(num_cards)
  end
  
  def next_card!
    @shoe.next_card!
  end
  
  def clear
    @players.each{ |player| player.clear_hands }
    @dealer.clear_hands
  end
  
  def results
    @players.each do |player|
      player.collect(@dealer.hand_rank)
    end
  end
    
  def add_player(names, money)
    names.each{ |name| @players << Player.new(name, money) }
  end
  
  def play
    self.take_bets
    self.deal
    self.turns
    self.dealer
    self.collect
    self.empty? 
  end
  
  def take_bets
    @players.each{ |player| player.make_bet }
  end
  
  def turns
    @players.each do |player| 
      action = player.take_turn
    end
    @dealer.take_turn
  end
  
  def collect
    @players.each{ |player| player.collect }
    @dealer.collect
  end
    
  def empty?
    @players.empty?
  end
    
end