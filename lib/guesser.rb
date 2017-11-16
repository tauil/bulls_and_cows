module Guesser
  attr_accessor :guessed_words, :bulls, :cows

  def set_new_guess_word
    case score
    when [0, 0]
      delete_all_words_with_letters
      @guessed_words = random_word
    when [0, 1]
    when [0, 2]
      if @prev_cows == 2
        if @first_syllable
          @guessed_words = dictionary.select{|word| word.match(/^#{guess[0..1].reverse}/)}
        else
          @guessed_words = dictionary.select{|word| word.match(/#{guess[2..3].reverse}$/)}
        end
      end
    when [0, 3]
    when [0, 4]
      permutation_words = guess.scan(/[a-z]/).permutation.map &:join
      @guessed_words = dictionary.select{|w| permutation_words.include?(w) }
    when [1, 0]
      find_by_syllable if (guessed_words.nil? || guessed_words.empty?) && @first_syllable.nil?
      @guess = guessed_words.first
      guessed_words.delete(guess)
    when [1, 1]
    when [1, 2]
    when [1, 3]
    when [2, 0]
      if @first_syllable
        puts "Keep using current set of words. One of them is the one. Current set: #{guessed_words}"
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
  end

  private

  def score
    [bulls, cows]
  end

  def delete_all_words_with_letters
    words_to_delete = dictionary.select{|word| word.match(/[#{guess}]/)}
    words_to_delete.map do |word|
      dictionary.delete(word)
    end
    puts "WORDS to delete: #{words_to_delete}"
  end

  def find_by_syllable
    @first_syllable = true
    @guessed_words = dictionary.select{|word| word.match(/^#{guess[0..1]}/)}

    if guessed_words.empty?
      @first_syllable = false
      @guessed_words = dictionary.select{|word| word.match(/#{guess[2..3]}$/)}
    end
  end
end
