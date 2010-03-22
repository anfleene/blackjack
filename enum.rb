class Enum
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

  def self.[](index)
    @hash.index(index)
  end
end