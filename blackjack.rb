#!/usr/bin/env ruby
require 'lib/table'
#initialize a new table
@table = Table.new
#valid menu choices
@menu_choices = ["invalid", "add_player", "start_game"]
#add a player to the table
def add_player
  puts "Add A New Player"
  puts "Name:"
  name = gets.chomp
  puts "Bankroll:"
  money = gets.chomp.to_i
  @table.add_player(name, money)
end
#start the game loop until the player decides to leave
def start_game
  add_player if @table.empty?
  puts "Let The Games Begin"
  while true
    @table.play
    break if @table.empty?
  end
end
#invalid choice
def invalid
  puts "Invalid Choice, Please Try Again"
end
#print menu and read choice
def menu
  puts "1. Add New Player"
  puts "2. Play"
  puts "Q. Quit"
  input = gets.chomp
  Process.exit if input.downcase == "q"
  #convert the input to an int if its not it will make it 0(the invalid choice)
  send(@menu_choices[input.to_i])
end

#menu loop
while true
  menu
end