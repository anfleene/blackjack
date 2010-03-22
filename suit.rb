require 'enum'
class Suit < Enum
  [:Spades,:Hearts,:Clubs,:Dimonds].each_with_index do |suit, index|
    Suit.add_item suit, index
  end
end