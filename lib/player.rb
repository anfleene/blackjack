require 'lib/card'
require 'lib/hand'
require 'lib/table'
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
    self.more_money unless @money > 0
    return if @bet.to_i > 0 && repeat_current_bet?
    puts "#{name} Place Your Bet(Available Bankroll is: #{@money})"
    input = gets.chomp.to_i
    unless input > 0 && input <= @money
      puts "Invalid Input Please Try again"
      input = self.make_bet
    end
    @bet = input
  end
  
  def more_money
    puts "Your Bankroll is empty"
    puts "1.Leave Table"
    puts "2.Insert Money"
    input = gets.chomp.to_i
    if(input == 1)
      self.table.leave(self)
    elsif(input == 2)
      puts "Bankroll:"
      input = gets.chomp.to_i
      while(input <= 0)
        puts "Invalid Input Please Try again"
        input = gets.chomp.to_i
      end
      @money = input if input > 0
    else
      puts "Invalid Input Please Try again"
      self.more_money
    end
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