# Bulls and Cows Game written in Ruby
# Author: Rafael Borgonovi Tauil

require 'pry-byebug'

# http://www.yougowords.com/4-letters-5
@dictionary = %w(life love near ring wolf fish five king over time able have sing star city soul rich duck film lion anna meme live safe pain rain sion iron once with fire care cake back lady away work self mole golf nine mary body down land blue gone kate come high hard rock rose wish ting baby home long line hand girl hope wind tina born open wife bird sure bean hair late mine hero dark jack evil leaf list math goat kids adam head ship face erin wine many hate like oven zone pear desk fear zeus side gate zing done asia bear bone pink emma taco nina band sand mate east snow maya unit best gift bush sian rate yeah move mark corn play zero card ling also town lost bomb sick prom word lord acid lily dove that rest ryan idea them cent tate gram four gold tube game year thin dish beau itch bath grow rage worm kite soft shot even poem know ding nice step loaf form june rice path ugly silk show name suit bulb josh race true tent rous wifi barn cute tone lane cole cold yard date gain cube past cone tune fair arch than what rush fate park berg oink sock levi lava nova york some fast mind turn rome farm wave)
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

def find_by_syllable(string_guess)
  @words_starts_same = @dictionary.select{|word| word.match(/^#{string_guess[0..1]}/)}
  @words_starts_same = @dictionary.select{|word| word.match(/#{string_guess[2..3]}$/)} if @words_starts_same.empty?
end

def find_by_first_letters(string_guess)
  @words_starts_same = @dictionary.select{|word| word.match(/^#{string_guess[0]}/)}
  @words_starts_same = @dictionary.select{|word| word.match(/^.#{string_guess[1]}/)} if @words_starts_same.empty?
end

def running
  if @guess.nil? || (@bulls == 0 && @cows == 0)
    # first try: get random word from dictionary
    @guess = @dictionary[rand(@dictionary.size)]
  else
    if (@bulls > @prev_bulls.to_i) || (@cows > @prev_cows.to_i)
      @best_guess = @guess
    end

    puts "Best guess at the moment: #{@best_guess}" if @best_guess

    if (@bulls == @prev_bulls.to_i) && @starting_letters
      puts "\nFirst two letters are good match. Find which is the right\n"
      @words_starts_same = @dictionary.select{|word| word.match(/^#{@best_guess[0]}/)}
      @guess = @words_starts_same.first
      @words_starts_same.delete(@guess)
    else

      if @words_starts_same.nil?
        @starting_letters = true
        puts "Getting words that starts with #{@best_guess[0..1]}"
        @words_starts_same = @dictionary.select{|word| word.match(/^#{@best_guess[0..1]}/)}

        if @words_starts_same.empty?
          @starting_letters = false
          @ending_letters = true
          puts "Getting words that ends with #{@best_guess[2..3]}"
          @words_starts_same = @dictionary.select{|word| word.match(/#{@best_guess[2..3]}$/)}

          if @words_starts_same.empty?
            @starting_letters = false
            @ending_letters = false
            @words_starts_same = [@dictionary[rand(@dictionary.size)]]
          end
        end

        @guess = @words_starts_same.first
      else
        if @words_starts_same.empty?
          puts "Getting words that ends with #{@best_guess[2..3]}"
          @words_starts_same = @dictionary.select{|word| word.match(/#{@best_guess[2..3]}$/)}
        end

        @guess = @words_starts_same.first
        @words_starts_same.delete(@guess)
      end

    end

    puts "\nNext words to try: #{@words_starts_same}\n"
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

  puts "Discarding #{@guess} from possible options"
  @dictionary.delete(@guess)
  binding.pry if @dictionary.select{|w| w == @guess}.any?
  @attempts.push({bulls: @bulls, cows: @cows, guess: @guess})
  @attempt += 1

  true
end

while running
  next
end

puts "Done"
