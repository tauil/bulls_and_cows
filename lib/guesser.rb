module Guesser
  attr_accessor :bulls, :cows, :attempts, :attempt_index

  def set_new_guess
    @attempts ||= []
    @attempt_index ||= 1

    case score
    when [0, 0]
      delete_all_words_with_letters
    when [0, 1]
      default_update_dictionary
    when [0, 2]
      default_update_dictionary
    when [0, 3]
      default_update_dictionary
    when [0, 4]
      binding.pry
      permutation_words = guess.scan(/[a-z]/).permutation.map &:join
      @dictionary = dictionary.select{|w| permutation_words.include?(w) }
    when [1, 0]
      default_update_dictionary
    when [1, 1]
      default_update_dictionary
    when [1, 2]
      default_update_dictionary
    when [1, 3]
      default_update_dictionary
    when [2, 0]
      letter_combination_1 = guess[0..1]
      letter_combination_2 = guess[1..2]
      letter_combination_3 = guess[2..3]
      @dictionary = filter_dictionary_by_letters(letter_combination_1) + filter_dictionary_by_letters(letter_combination_2) + filter_dictionary_by_letters(letter_combination_3)
    when [2, 1]
      default_update_dictionary
    when [2, 2]
    when [3, 0]
      first_three_letters = guess[0..2]
      last_three_letters = guess[1..3]
      @dictionary = filter_dictionary_by_letters(first_three_letters) + filter_dictionary_by_letters(last_three_letters)
    when [3, 1]
      default_update_dictionary
    when [4, 0]
      puts "Found"
    else
      puts "Found a bug"
      return false
    end

    attempts.push({bulls: bulls, cows: cows, guess: guess})
    @attempt_index += 1
  end

  private

  def score
    [bulls, cows]
  end

  def filter_dictionary_by_letters(letters)
    regex = letters.scan(ONLY_LETTERS).map{|letter| "(?=.*#{letter})"}.join
    dictionary.select { |word| word.match(/^#{regex}.*$/) }
  end

  def delete_all_words_with_letters
    filter_dictionary_by_letters(guess).map do |word|
      dictionary.delete(word)
    end
  end

  def default_update_dictionary
    @dictionary = dictionary.select{|w| w.match(/[#{guess}]/) && w != guess}
  end
end
