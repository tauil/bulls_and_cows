# Bulls and Cows Game written in Ruby
# Author: Rafael Borgonovi Tauil

require 'pry-byebug'

ONLY_LETTERS=/[a-z]/
@letters_to_try = ('a'..'z').to_a

@attempt = 0
@attempts = []
puts "Enter the desired secret word:"
SECRET_WORD = gets.chomp

def generate_guess(letters = nil)
  if letters.nil?
    guess = []
  else
    guess = letters
  end

  # 4 letters word
  while guess.size < 4
    letter = @letters_to_try[rand(@letters_to_try.size)]
    guess.push(letter) if !guess.include?(letter)
  end

  guess.join
end

def running
  if @bulls.nil? && @cows.nil?
    # first try generate random letters
    @guess = generate_guess
  else
    if @attempt == 2
      # second try, repeat first two letters
      letters = @guess.scan(ONLY_LETTERS)[0..1]
      @guess = generate_guess(letters)
    elsif @attempt == 3
      # third try, repeat last two letters from the first attempt
      letters = @attempts[0][:guess].scan(ONLY_LETTERS).reverse[0..1]
      @guess = generate_guess(letters)
    end

  end

  if @guess == SECRET_WORD
    puts "Secret word is: #{@guess}"
    return false
  end

  puts "Current secret  : #{SECRET_WORD}"
  puts "Current guess   : #{@guess}"

  puts "How many Bulls?"
  @bulls = gets.chomp.to_i

  puts "How many Cows?"
  @cows = gets.chomp.to_i

  if @bulls == 0 && @cows == 0
    letters = @guess.scan(ONLY_LETTERS)
    @letters_to_try = @letters_to_try - letters
  end

  @attempts.push({bulls: @bulls, cows: @cows, guess: @guess})
  @attempt += 1

  true
end

while running
  next
end

puts "Done"
