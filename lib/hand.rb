require 'lib/dealer'
#returns the next card but doesn't pop it
class Hand
  #cards is an array of cards and bet is the bet on the current set of cards
  attr_accessor :cards, :bet

  #construct
  def initialize(card, bet, player)
    @player = player
    @bet = bet
    #add the card to the hand
    @cards = [card]
  end
  
  #what is the total rank of the hand
  def rank  
    #what is the total rank of the hand
    aces = @cards.find_all{ |card| card.rank == :Ace }
    #generates the max total(the default value for all cards)
    #the map here calls the function rank_value on all the cards
    #the inject then sums the values
    total = @cards.empty? ? 0 : @cards.map(&:rank_value).inject(:+) 
    #find highest value without busting(if possible) 
    while !aces.empty? && total > 21
      total -= 10
      aces.pop
    end
    total
  end

  #find highest value without busting(if possible) 
  def busted?
    self.rank > 21
  end

  #the user got a 2 card 21  
  def blackjack?
    self.size == 2 && self.rank == 21
  end

  #returns the number of cards in a hand
  def size
    @cards.size
  end
  
  #input is take for the users turn for this hand
  def take_turn
    #output the dealer's hand
    puts self.dealer
    #output current hand    
    puts self
    #print options    
    options
    input = gets.chomp.to_i
    #set option if its valid or set it to invalid
    option = options_array[input].nil?  ? "invalid" : options_array[input]
    #preform the option if its a valid option
    #else recurse until a vaild option is selected
    unless option == "invalid"
      send option
    else
      puts "Invalid Input Please Try again"
    end
    #recures until the user has busted or decided to stand
    self.take_turn unless @stand || self.busted?
  end
  
  #this determines the payout of the hand
  def collect
    case
      #black jack pays 1.5 bet
      when self.blackjack?
        @player.money += (@bet*1.5)
        #print winnings
        self.winner(@bet*1.5)
      when self.busted?
        @player.money -= @bet
        #print loss
        self.loser(@bet)
      when self.dealer.busted?
        @player.money += @bet
        self.winner(@bet)
      when self.rank < self.dealer.rank
        @player.money -= @bet
        self.loser(@bet)
      when self.rank > self.dealer.rank
        @player.money += @bet
        self.winner(@bet)        
    end
  end
  
  #add the card to the hand
  def <<(card)
    @cards << card
  end
  
  #add another card to hand
  def hit
    @cards << self.table.next_card! unless self.busted?
  end
  
  #flag the user has decided to stand
  def stand
    @stand = true
  end
  
  #the user has doubled down, double bet, hit one card, and flag stand
  def double_down
    @bet *= 2
    self.hit
    @stand = true
  end  
  
  #the user has decided to split, pass off the player to perform this action
  def split
    @player.split(self)
  end
  
  #print the hand in a semi pretty way
  def to_s
    string = @player.to_s
    string << "\n-------------------------\n"
    @cards.each do |card|
      string << card.to_s
      string << "\n"
    end
    string << "-------------------------\n\n"
  end
  
  #the player has won print the ammount
  def winner(ammount)
    puts "#{@player}\n Winner: #{ammount}"
  end
  
  #the player has lost print the ammount
  def loser(ammount)
      puts "#{@player}\n Loser: #{ammount}"
  end
  
  #print the default hand options, and the extra options if the hand meets the requirements
  def options
    puts "1.Hit"
    puts "2.Stand"
    puts "3.Double Down" if self.can_double_down?
    puts "4.Split" if self.can_split?
  end
  
  #you can only double down after two cards
  def can_double_down?
    @cards.size == 2
  end
  
  #the hand contains the passed rank
  def include?(rank)
    @cards.map(&:rank).include?(rank)
  end
  
  #you can split only on the second card if it is the same as the first
  def can_split?
    @cards.size == 2 && @cards.map(&:rank).map{ |rank| Rank[rank] }.uniq.size == 1
  end
  
  #array of valid options
  def options_array
    array = ["invalid", "hit", "stand"]
    array << "double_down" if self.can_double_down?
    array << "split" if self.can_split?
    array
  end
  
  
  #hack hack find the dealer in memory
  def dealer
    @dealer ||= ObjectSpace.each_object.find{ |o| o.kind_of?(Dealer) }
  end
  
  #hack hack find the table in memory
  def table
    @table ||= ObjectSpace.each_object.find{ |o| o.kind_of?(Table) }
  end
  
end