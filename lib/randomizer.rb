#this is a "monkey patch" of the array class, it adds randomize function to arrays
class Array
  #this function will return a random version of the array to the caller
  def randomize
    array_copy, new_array = self.dup, self.class.new
    new_array << array_copy.slice!(rand(array_copy.size)) until new_array.size.eql?(self.size)
    new_array
  end
  
  #this function will clober the caller and replace it with the new array
  def randomize!
    self.replace(randomize)
  end
end
