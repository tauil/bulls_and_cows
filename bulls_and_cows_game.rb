# Bulls and Cows Game written in Ruby
# Author: Rafael Borgonovi Tauil

require 'pry-byebug'
require_relative 'lib/game_core'

def running
  @game.set_guess

  puts @game.show_guess

  puts "How many Bulls?"
  @game.bulls = gets.chomp.to_i

  puts "How many Cows?"
  @game.cows = gets.chomp.to_i

  @game.update_guess

  @game.running?
end

puts "Enter the desired secret word:"
secret_word = gets.chomp

@game = Game.new(secret_word)

while running
  next
end
