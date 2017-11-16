require 'pry-byebug'
require_relative 'guesser'

# http://www.yougowords.com/4-letters-5
DICTIONARY = %w(life love near ring wolf fish five king over time able have sing star city soul rich duck film lion anna meme live safe pain rain sion iron once with fire care cake back lady away work self mole golf mary body down land blue gone kate come high hard rock rose wish ting baby home long line hand girl hope wind tina born open wife bird sure bean hair late mine hero dark jack evil leaf list math goat kids adam head ship face erin wine many hate like oven zone pear desk fear zeus side gate zing done asia bear bone pink emma taco band sand mate east snow unit best gift bush sian rate yeah move mark corn play zero card ling also town lost sick prom word lord acid lily dove that rest ryan idea them cent tate gram four gold tube game year thin dish beau itch bath grow rage worm kite soft shot poem know ding nice step loaf form june rice path ugly silk show name suit bulb josh race true tent rous wifi barn cute tone lane cole cold yard date gain cube past cone tune fair arch than what rush fate park berg oink sock levi lava nova york some fast mind turn rome farm wave)
ONLY_LETTERS=/[a-z]/

class Game
  include Guesser
  attr_accessor :dictionary, :secret_word, :guess

  def initialize(secret_word, dictionary = nil)
    @dictionary = dictionary || DICTIONARY
    @secret_word = secret_word
  end

  def running?
    !found_secret_word
  end

  def show_guess
    "Dictionary: #{dictionary} : #{dictionary.size} words\n ---------------------------------- \n   Current secret: #{secret_word}\n    Current guess: #{guess}\n ---------------------------------- "
  end

  def update_guess
    set_new_guess
  end

  def set_guess
    @guess = random_word
  end

  private

  def found_secret_word
    guess == secret_word
  end

  def random_word
    dictionary[rand(dictionary.size)]
  end
end
