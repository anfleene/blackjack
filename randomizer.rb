class Array
  def randomize
    array_copy, new_array = self.dup, self.class.new
    new_array << array_copy.slice!(rand(array_copy.size)) until new_array.size.eql?(self.size)
    new_array
  end

  def randomize!
    self.replace(randomize)
  end
end
