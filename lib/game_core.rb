# http://www.yougowords.com/4-letters-5
DICTIONARY = %w(life love near ring wolf fish five king over time able have sing star city soul rich duck film lion anna meme live safe pain rain sion iron once with fire care cake back lady away work self mole golf nine mary body down land blue gone kate come high hard rock rose wish ting baby home long line hand girl hope wind tina born open wife bird sure bean hair late mine hero dark jack evil leaf list math goat kids adam head ship face erin wine many hate like oven zone pear desk fear zeus side gate zing done asia bear bone pink emma taco band sand mate east snow unit best gift bush sian rate yeah move mark corn play zero card ling also town lost sick prom word lord acid lily dove that rest ryan idea them cent tate gram four gold tube game year thin dish beau itch bath grow rage worm kite soft shot poem know ding nice step loaf form june rice path ugly silk show name suit bulb josh race true tent rous wifi barn cute tone lane cole cold yard date gain cube past cone tune fair arch than what rush fate park berg oink sock levi lava nova york some fast mind turn rome farm wave)
ONLY_LETTERS=/[a-z]/

class Game
  attr_accessor :dictionary, :bulls, :cows, :secret_word, :guess

  def initialize(secret_word)
    @dictionary = DICTIONARY
    @secret_word = secret_word
    generate_first_guess
  end

  def running?
    !found_secret_word
  end

  def status
    puts " ---------------------------------- "
    puts "   Current secret: #{secret_word}"
    puts "    Current guess: #{guess}"
    puts " ---------------------------------- "
  end

  private

  def found_secret_word
    guess == secret_word
  end

  def generate_first_guess
    @guess = random_word
  end

  def random_word
    dictionary[rand(dictionary.size)]
  end
end
