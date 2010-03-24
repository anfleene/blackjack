class Rank
  
  def self.const_missing(key)
      @array.select{ |k| key == k.first }.first[1]
  end
  
  def self.each
    @array.each {|key,value| yield(key,value)}
  end
  
  def self.all
    @array
  end
  
  def self.size
    @array.size
  end
  
  def self.[](key)
    begin
      @array[key][0]
    rescue TypeError
      @array.select{ |k| key == k.first }.first[1]
    end
  end
  # get the array index (Rank.index(:Two) returns 0, Rank.index(:Ten) returns 8)
  def self.index(key)
    @array.index([key, Rank[key]])
  end
  
  @array ||= [[:Two,2], [:Three,3], [:Four, 4], [:Five, 5], [:Six, 6], [:Seven, 7], [:Eight, 8], [:Nine, 9], [:Ten, 10], [:Jack, 10], [:Queen, 10], [:King, 10], [:Ace, 11]]
end