require 'lib/shoe'
require 'lib/dealer'
#this class is the physical table that the players are at
class Table
  #shoe is the card container, array of players, and the dealer that never leaves
  attr_accessor :shoe, :players, :dealer, :current_player
  # constructor
  def initialize
    @players = []
    @shoe = Shoe.new
    @dealer = Dealer.new("Dealer")
  end
  #deal out a number of cards to all players, then the dealer defaults to 2
  
  def deal(num_cards=2)
    #if the shoe is almost empty build a new one
    if @shoe.re_shuffle?
      @shoe = Shoe.new 
      puts "Starting a New Shoe"
    end
    #deal out the cards 
    @players.each{|player| player.deal(num_cards)}
    @dealer.deal(num_cards)
  end
  
  #pops the shoes top card and returns it
  def next_card!
    @shoe.next_card!
  end
    
  #add a player to the table
  def add_player(names, money)
    names.each{ |name| @players << Player.new(name, money) }
  end
  
  #play loop, take bets then deal out the cards, give the players turns, then collect/pay out money
  def play
    self.take_bets
    self.deal
    self.turns
    self.collect
  end
  
  #remove the arg player form the table
  def leave(player)
    @players.delete(player)
  end
  
  #allow each player to place a bet
  def take_bets
    @players.each{ |player| player.make_bet }
  end
  
  #give each player a turn and then give the dealer a turn
  def turns
    @players.each do |player| 
      action = player.take_turn
    end
    @dealer.take_turn
  end
  
  #collect winnings/pay out to each player and clear all hands
  def collect
    @players.each{ |player| player.collect }
    @dealer.collect
  end
    
  #if the table is empty no games can be played
  def empty?
    @players.empty?
  end
  
  #is the player sitting at the table
  def include?(player)
    @players.include?(player)
  end
    
end