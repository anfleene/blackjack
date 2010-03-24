require 'card'
require 'hand'
require 'table'
class Player
  attr_accessor :hands, :name, :money, :bet
  
  def initialize(name=nil, money=nil)
    @name=name
    @money=money.to_i
    @hands = []
  end
  
  def deal(num_cards)
    num_cards.times do
      self << self.table.next_card!
    end
  end
  
  def <<(card)
    return @hands.first << card unless @hands.first.nil?
    @hands << Hand.new(card, @bet, self)
  end
  
  def split(hand)
    new_hand = Hand.new(hand.cards.pop, hand.bet, self)
    @hands << new_hand
    hand.hit
    new_hand.hit
  end
  
  def clear_hands
    @hands = []
  end
  
  def make_bet
    return if @bet.to_i > 0 && repeat_current_bet?
    puts "#{name} Place Your Bet"
    input = gets.chomp.to_i
    unless input > 0  
      puts "Invalid Input Please Try again"
      input = self.make_bet 
    end
    @bet = input
  end
  
  def repeat_current_bet?
    puts "Would you like to repeat your previous bet of #{@bet}(yes/no)"
    input = gets.chomp
    !!input.match(/yes/i)
  end
  
  def take_turn
    @hands.each{ |hand| hand.take_turn; puts hand }
  end
  
  def collect
    @hands.each{ |hand| hand.collect }
    @hands =[]
  end
  
  def table
    @table ||= ObjectSpace.each_object.find{ |o| o.kind_of?(Table) }
  end
  
  def to_s
    "#{name}: Current Bet: #{@bet}, Bankroll: #{@money} "
  end
end