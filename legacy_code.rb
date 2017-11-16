@attempt = 1
@attempts = []

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

def old_running

  if (@bulls > @prev_bulls.to_i) || (@cows > @prev_cows.to_i)
    @best_guess = @guess
  end

  puts "Best guess at the moment: #{@best_guess}" if @best_guess

  score = [@bulls, @cows]

  # CASE here

  puts "Discarding #{@guess} from possible options"
  @dictionary.delete(@guess)
  binding.pry if @dictionary.select{|w| w == @guess}.any?
  @attempts.push({bulls: @bulls, cows: @cows, guess: @guess})
  @attempt += 1

  true
end
