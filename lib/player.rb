require 'lib/card'
require 'lib/hand'
require 'lib/table'
#this is the player class, each member is either a computer(a dealer) or a user
class Player
  #contains hands(may have more than one in the case of a split), a player name, the players bankroll, and the current bet
  attr_accessor :hands, :name, :money, :bet
  
  #construct a new player with name and bankroll
  def initialize(name=nil, money=nil)
    @name=name
    @money=money.to_i
    #initialize the hands array
    @hands = []
  end
  
  #pop the next num_cards(usually 2) off the table and put them into the users hand
  def deal(num_cards)
    num_cards.times do
      self << self.table.next_card!
    end
  end
  
  #places a card into either the first hand a user has or creates a new hand and places the card there
  def <<(card)
    return @hands.first << card unless @hands.first.nil?
    @hands << Hand.new(card, @bet, self)
  end
  
  #split a hand into two and add one more card to each hand
  def split(hand)
    new_hand = Hand.new(hand.cards.pop, hand.bet, self)
    @hands << new_hand
    hand.hit
    new_hand.hit
  end
  
  #the function allows the user to place a bet
  def make_bet
    #if the user is out of money they must add more
    self.more_money unless @money > 0
    #you cant place bets at a table you aren't sitting at, use case is that the user decided to leave when
    #they were out of money
    return unless self.table.include?(self)
    #return if you have enough money and decide to repeat the current bet
    return if @bet.to_i > 0 && repeat_current_bet?
    #place your new bet
    puts "#{name} Place Your Bet(Available Bankroll is: #{@money})"
    input = gets.chomp.to_i
    #the to_i converts invalid input to 0, you cant bet more than you have
    unless input > 0 && input <= @money
      puts "Invalid Input Please Try again"
      #recurse until a valid bet is made
      input = self.make_bet
    end
    #set the bet
    @bet = input
  end
  
  #this method allows you to bring more money to the table or get up and leave
  def more_money
    puts "Your Bankroll is empty"
    puts "1.Leave Table"
    puts "2.Insert Money"
    input = gets.chomp.to_i
    if(input == 1)
      #the user wants to leave
      self.table.leave(self)
    elsif(input == 2)
      #add more money(repeat until vaild dollar amount is given)
      puts "Bankroll:"
      input = gets.chomp.to_i
      while(input <= 0)
        puts "Invalid Input Please Try again"
        input = gets.chomp.to_i
      end
      @money = input if input > 0
    else
      #recurse until a valid input is given
      puts "Invalid Input Please Try again"
      self.more_money
    end
  end
  
  #this allows the user to repeat the current bet if they please
  def repeat_current_bet?
    #cant repeat if you dont have enough
    return false if @bet > @money
    puts "#{@name} Would you like to repeat your previous bet of #{@bet}(yes/no)"
    input = gets.chomp
    #matches yes(case insensitive) !! converts the returned match to a boolean(dont care what the match data was just that it existed)
    !!input.match(/yes/i)
  end
  
  #loops through all the users turns(may be more than one if the user split a hand)
  def take_turn
    @hands.each{ |hand| hand.take_turn; puts hand }
  end
  
  #collect winnings and losses from all hands
  def collect
    @hands.each{ |hand| hand.collect }
    @hands =[]
  end
  
  #hack hack hack, hopefully there is only one table in memory
  #returns the first instance of table found in memory and stores it as an instance var
  def table
    @table ||= ObjectSpace.each_object.find{ |o| o.kind_of?(Table) }
  end
  
  #stringify the player
  def to_s
    "#{name}: Current Bet: #{@bet}, Bankroll: #{@money} "
  end
end