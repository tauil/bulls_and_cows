# Bulls and Cows Game written in Ruby
# Author: Rafael Borgonovi Tauil

require 'pry-byebug'

@attempt = 0
puts "Enter the desired secret word:"
SECRET_WORD = gets.chomp

puts "Picked number is: #{MAX}"

def running()
  puts "Attempt #{@attempt}"

  if @guess == SECRET_WORD
    puts "Secret word is: #{@guess}"
    return false
  end

  @attempt += 1
  true
end

while running
  next
end

puts "Done"
