require 'enum'
class Rank < Enum
  (2.upto(10).to_a + [:Jack, :Queen, :King, :Ace]).each_with_index do |rank, index|
    Rank.add_item rank, index
  end
end