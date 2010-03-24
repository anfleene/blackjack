class Suit
  def self.add_item(key,value)
      @hash ||= {}
      @hash[key]=value
  end
  def self.const_missing(key)
      @hash[key]
  end   
  def self.each
      @hash.each {|key,value| yield(key,value)}
  end
  
  def self.all
    @hash
  end
  
  def self.size
    @hash.size
  end

  def self.[](index)
    index.kind_of?(Symbol) ? @hash[index] : @hash.index(index)
  end
  
  [:Spades,:Hearts,:Clubs,:Dimonds].each_with_index do |suit, index|
    Suit.add_item suit, index
  end
end