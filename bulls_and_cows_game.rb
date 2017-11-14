# Bulls and Cows Game written in Ruby
# Author: Rafael Borgonovi Tauil

require 'pry-byebug'

ONLY_LETTERS=/[a-z]/
ALPHABET = ('a'..'z').to_a

@attempts = []
puts "Enter the desired secret word:"
SECRET_WORD = gets.chomp

def generate_guess
  guess = []

  # 4 letters word
  while guess.size < 4
    letter = ALPHABET[rand(ALPHABET.size)]
    guess.push(letter) if !guess.include?(letter)
  end

  guess.join
end

def running()
  puts "Attempt #{@attempts.size}"

  @guess = generate_guess

  if @guess == SECRET_WORD
    puts "Secret word is: #{@guess}"
    return false
  end

  puts "How many Bulls?"
  @bulls = gets.chomp.to_i

  puts "How many Cows?"
  @cows = gets.chomp.to_i

  if @bulls > 0 || @cows > 0
    letters = @guess.scan(ONLY_LETTERS)
    @attempts.push({bulls: @bulls, cows: @cows, letters: letters})
  end

  true
end

while running
  next
end

puts "Done"
