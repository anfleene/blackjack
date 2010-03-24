require 'lib/dealer'
class Hand
  attr_accessor :cards, :bet
  
  def initialize(card, bet, player)
    @player = player
    @bet = bet
    @cards = [card]
  end
  
  def rank  
    aces = @cards.find_all{ |card| card.rank == :Ace }
    total = @cards.empty? ? 0 : @cards.map(&:rank_value).inject(:+) 
    return total if total < 22 && aces.empty?
    while !aces.empty? && total > 21
      total -= 10
      aces.pop
    end
    total
  end
  
  def busted?
    self.rank > 21
  end
  
  def blackjack?
    self.size == 2 && self.rank == 21
  end
  
  def size
    @cards.size
  end
  
  def take_turn
    puts self.dealer
    puts self
    options
    input = gets.chomp.to_i
    option = options_array[input].nil?  ? "invalid" : options_array[input]
    unless option == "invalid"
      send option
    else
      puts "Invalid Input Please Try again"
    end
    self.take_turn unless @stand || self.busted?
  end
  
  def collect
    case
      when self.blackjack?
        @player.money += (@bet*1.5)
        self.winner(@bet*1.5)
      when self.busted?
        @player.money -= @bet
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
  
  def <<(card)
    @cards << card
  end
  
  def hit
    @cards << self.table.next_card! unless self.busted?
  end
  
  def stand
    @stand = true
  end
  
  def double_down
    @bet *= 2
    self.hit
    @stand = true
  end  
  
  def split
    @player.split(self)
  end
  
  def to_s
    string = @player.to_s
    string << "\n-------------------------\n"
    @cards.each do |card|
      string << card.to_s
      string << "\n"
    end
    string << "-------------------------\n\n"
  end
  
  def winner(ammount)
    puts "#{@player}\n Winner: #{ammount}"
  end
  
  def loser(ammount)
      puts "#{@player}\n Loser: #{ammount}"
  end
  
  def options
    puts "1.Hit"
    puts "2.Stand"
    puts "3.Double Down" if self.can_double_down?
    puts "4.Split" if self.can_split?
  end
  
  def can_double_down?
    @cards.size == 2
  end
  
  def include?(rank)
    @cards.map(&:rank).include?(rank)
  end
  
  def can_split?
    @cards.size == 2 && @cards.map(&:rank).map{ |rank| Rank[rank] }.uniq.size == 1
  end
  
  def options_array
    array = ["invalid", "hit", "stand"]
    array << "double_down" if self.can_double_down?
    array << "split" if self.can_split?
    array
  end
  
  
  def dealer
    @dealer ||= ObjectSpace.each_object.find{ |o| o.kind_of?(Dealer) }
  end
  
  def table
    @table ||= ObjectSpace.each_object.find{ |o| o.kind_of?(Table) }
  end
  
end