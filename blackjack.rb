#!/usr/bin/env ruby
require 'pp'
require 'table'
@table = Table.new
@menu_choices = ["invalid", "add_player", "start_game"]
def add_player
  puts "Player Name:"
  name = gets.chomp
  puts "Bankroll:"
  money = gets.chomp.to_i
  @table.add_player(name, money)
end

def start_game
  while true
    break unless @table.play
  end
end

def invalid
  puts "Invalid Choice, Please Try Again"
end

def menu
  puts "1. Add New Player"
  puts "2. Play"
  puts "Q. Quit"
  input = gets.chomp
  Process.exit if input.downcase == "q"
  send(@menu_choices[input.to_i])
end

while true
  menu
end



# ARGF.each_line do |input|
#   add_player(*input.split(","))
#   pp @table
# end

  
