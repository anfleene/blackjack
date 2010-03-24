class Suit
  #add the enom to the class
  def self.add_item(key,value)
      @hash ||= {}
      @hash[key]=value
  end
  
  #allows class level access of the enom Suit::Hearts
  def self.const_missing(key)
      @hash[key]
  end   
  
  #allows the ability to loop through the enoms
  def self.each
      @hash.each {|key,value| yield(key,value)}
  end
  
  #returns all the enoms
  def self.all
    @hash
  end
  
  #returns the size of the enoms
  def self.size
    @hash.size
  end

  #allows direct access to the name or the value
  def self.[](index)
    #if a name is passed return the index, if index is passed return the name
    index.kind_of?(Symbol) ? @hash[index] : @hash.index(index)
  end
  
  #add all the suits to the enom
  [:Spades,:Hearts,:Clubs,:Dimonds].each_with_index do |suit, index|
    Suit.add_item suit, index
  end
end