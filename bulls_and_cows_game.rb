# Bulls and Cows Game written in Ruby
# Author: Rafael Borgonovi Tauil

require 'pry-byebug'

# http://www.yougowords.com/4-letters-5
@dictionary = %w(life love near ring wolf fish five king over time able have sing star city soul rich duck film lion anna meme live safe pain rain sion iron once with fire care cake back lady away work self mole golf nine mary body down land blue gone kate come high hard rock rose wish ting baby home long line hand girl hope wind tina born open wife bird sure bean hair late mine hero dark jack evil leaf list math goat kids adam head ship face erin wine many hate like oven zone pear desk fear zeus side gate zing done asia bear bone pink emma taco band sand mate east snow unit best gift bush sian rate yeah move mark corn play zero card ling also town lost sick prom word lord acid lily dove that rest ryan idea them cent tate gram four gold tube game year thin dish beau itch bath grow rage worm kite soft shot poem know ding nice step loaf form june rice path ugly silk show name suit bulb josh race true tent rous wifi barn cute tone lane cole cold yard date gain cube past cone tune fair arch than what rush fate park berg oink sock levi lava nova york some fast mind turn rome farm wave)
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
  @first_syllable = true
  @words_to_test = @dictionary.select{|word| word.match(/^#{string_guess[0..1]}/)}

  if @words_to_test.empty?
    @first_syllable = false
    @words_to_test = @dictionary.select{|word| word.match(/#{string_guess[2..3]}$/)}
  end
end

def find_by_first_letters(string_guess)
  @first_letter = true
  @words_to_test = @dictionary.select{|word| word.match(/^#{string_guess[0]}/)}

  if @words_to_test.empty?
    @first_letter = false
    @words_to_test = @dictionary.select{|word| word.match(/^.#{string_guess[1]}/)}
  end
end

def find_by_last_letters(string_guess)
  @last_letter = false
  @words_to_test = @dictionary.select{|word| word.match(/#{string_guess[2]}.$/)}

  if @words_to_test.empty?
    @last_letter = true
    @words_to_test = @dictionary.select{|word| word.match(/#{string_guess[3]}$/)}
  end
end

def delete_all_words_with_letters(letters)
  binding.pry
  words_to_delete = @dictionary.select{|word| word.match(/[#{letters}]/)}
  words_to_delete.map do |word|
    @dictionary.delete(word)
  end
  puts "WORDS to delete: #{words_to_delete}"
end

def find_words
  puts "find_words"
  if @first_syllable
    if @cows == 2 && @prev_cows == 2
      # First two letters are right but in wrong positions
      @words_to_test = @dictionary.select{|word| word.match(/^#{@guess[0..1].reverse}/)}
    elsif @cows == 1 && @bulls == 1
    end
  else
    if @cows == 2 && @prev_cows == 2
      @words_to_test = @dictionary.select{|word| word.match(/#{@guess[2..3].reverse}$/)}
    end
  end

  if @words_to_test.nil? || @words_to_test.empty?
    find_by_syllable(@best_guess) if @first_syllable.nil?

    # if @first_syllable && @bulls == 2
    #   find_by_first_letters(@best_guess) if @first_letter.nil?
    # else
    #   find_by_last_letters(@best_guess) if @last_letter.nil?
    # end
  end

  @guess = @words_to_test.first
  @words_to_test.delete(@guess)

  puts "\nNext words to try: #{@words_to_test}\n"
end

def running
  if @guess.nil?
    # first try: get random word from dictionary
    @guess = @dictionary[rand(@dictionary.size)]
  else
    if (@bulls > @prev_bulls.to_i) || (@cows > @prev_cows.to_i)
      @best_guess = @guess
    end

    puts "Best guess at the moment: #{@best_guess}" if @best_guess

    score = [@bulls, @cows]

    case score
    when [0, 0]
      delete_all_words_with_letters(@guess)
      @words_to_test = [@dictionary[rand(@dictionary.size)]]
    when [0, 1]
    when [0, 2]
      if @prev_cows == 2
        if @first_syllable
          @words_to_test = @dictionary.select{|word| word.match(/^#{@guess[0..1].reverse}/)}
        else
          @words_to_test = @dictionary.select{|word| word.match(/#{@guess[2..3].reverse}$/)}
        end
      end
    when [0, 3]
    when [0, 4]
      permutation_words = @guess.scan(/[a-z]/).permutation.map &:join
      @words_to_test = @distionary.select{|w| permutation_words.include?(w) }
    when [1, 0]
    when [1, 1]
    when [1, 2]
    when [1, 3]
    when [2, 0]
      if @first_syllable
        puts "Keep using current set of words. One of them is the one. Current set: #{@words_to_test}"
      else

      end
    when [2, 1]
    when [2, 2]
    when [3, 0]
    when [3, 1]
    when [4, 0]
      puts "Found"
    else
      puts "Found a bug"
      return false
    end

    binding.pry

    if @words_to_test.nil? || @words_to_test.empty?
      find_by_syllable(@guess) if @first_syllable.nil?
    else
      @guess = @words_to_test.first
      @words_to_test.delete(@guess)
    end
  end

  puts "#{@words_to_test}"

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
