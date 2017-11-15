# Bulls and Cows Game written in Ruby
# Author: Rafael Borgonovi Tauil

require 'pry-byebug'

# http://www.yougowords.com/4-letters-5
@dictionary = %w(life love near ness ring wolf fish five king else tree over time able have sing star city soul rich duck foot film lion anna meme live safe pain rain Sion iron once ball with fire wood care cake back lady away work self mole moon golf ally nine mary body less down land blue gone kate come high hard rock teen rose wish ting baby home long line hand girl food hope wind tina born open wife bird sure bean hair room late mine fall hero bell ever dark jack evil leaf list math goat kids adam head ship face erin wine many hate good edge like oven zone pear desk fear zeus side gate dana zing done asia bear bone pink emma taco nina band sand mate East snow maya unit best gift bush sian kiss rate yeah move mark corn play zero card ling book also town free lost bomb sick prom word Lord acid lily dove that rest ryan idea them cent tate gram four gold tube game year thin cook dish full beau itch bath grow rage worm kite soft shot even poem know ding nice step loaf form june rice path ugly silk show name suit bulb josh race true tent here rous mess wifi bull barn cute tone lane cole cold yard date gain cube past cone tune hall fair arch oreo than what rush fate park berg oink sock Levi lava nova York some fast mind turn rome farm wave ross)
ONLY_LETTERS=/[a-z]/
@letters_to_try = ('a'..'z').to_a

@attempt = 1
@attempts = []
puts "Enter the desired secret word:"
SECRET_WORD = gets.chomp

def generate_guess(letters = nil)
  if letters.nil?
    guess = @dictionary[rand(@dictionary.size)]
  else
    guess = letters
  end

  # 4 letters word
  while guess.size < 4
    letter = @letters_to_try[rand(@letters_to_try.size)]
    guess.push(letter) if !guess.include?(letter)
  end

  return guess.join if guess.is_a?(Array)
  guess
end

def running
  if @guess.nil? || (@bulls == 0 && @cows == 0)
    # first try: get random word from dictionary
    @guess = @dictionary[rand(@dictionary.size)]
  else
    if (@bulls > @prev_bulls.to_i) || (@cows > @prev_cows.to_i)
      @best_guess = @guess
    end

    if @words_starts_same.nil?
      puts "Getting words that starts with #{@best_guess[0..1]}"
      @words_starts_same = @dictionary.select{|word| word.match(/^#{@best_guess[0..1]}/)}
    else
      puts "Getting words that ends with #{@best_guess[2..3]}"
      @words_starts_same = @dictionary.select{|word| word.match(/#{@best_guess[2..3]}$/)} if @words_starts_same.empty?

      @guess = @words_starts_same.first
      @words_starts_same.delete(@guess)
    end
  end

  if @guess == SECRET_WORD
    puts "Secret word is: #{@guess}"
    return false
  end

  puts "Current secret  : #{SECRET_WORD}"
  puts "Current guess   : #{@guess}"

  @prev_bulls = @bulls
  puts "How many Bulls?"
  @bulls = gets.chomp.to_i

  @prev_cows = @cows
  puts "How many Cows?"
  @cows = gets.chomp.to_i

  if @bulls == 0 && @cows == 0
    @dictionary.delete(@guess)
  end

  @attempts.push({bulls: @bulls, cows: @cows, guess: @guess})
  @attempt += 1

  true
end

while running
  next
end

puts "Done"
