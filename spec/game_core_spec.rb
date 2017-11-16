require_relative '../lib/game_core'

describe 'Bulls and Cows Game' do
  let!(:secret_word) { 'word' }
  let!(:game) { Game.new(secret_word) }

  describe 'includes' do
    it 'Guesser' do
      expect(game).to be_a_kind_of(Guesser)
    end
  end

  describe '.initialize' do
    it 'sets dictionary' do
      expect(game.dictionary).to match(DICTIONARY)
    end

    it 'sets secret_word' do
      expect(game.secret_word).to eq(secret_word)
    end

    it 'generates first guess' do
      expect(game.guess).to_not be_nil
    end
  end

  describe '#running?' do
    context 'when secret_word is still not found' do
      it 'returns true' do
        expect(game.running?).to be_truthy
      end
    end

    context 'when secret_word has been found' do
      before { game.guess = secret_word }

      it 'returns false' do
        expect(game.running?).to be_falsy
      end
    end
  end

  describe '#status' do
    before { game.guess = 'tesy' }

    it 'displays current secret and current guess in a nicer way' do
      expect(game.status).to eq(" ---------------------------------- \n   Current secret: word\n    Current guess: tesy\n ---------------------------------- ")
    end
  end

  describe '#guess_new_word' do
    context 'given bulls and cows answers' do
      subject do
        game.guess = 'lost'
        game.bulls = 1
        game.cows = 0
        game.guess_new_word
      end

      it 'changes the guess word' do
        subject
        expect(game.guess).to_not eq('lost')
      end

      it 'sets guessed_words' do
        subject
        expect(game.guessed_words).to_not be_nil
      end
    end

    context 'when guessed word is 0 bulls and 0 cows' do
      let!(:game) { Game.new(secret_word) }
      let!(:words_to_be_deleted) { game.dictionary.select do |word|
                                     word.match(/^(?=.*l)(?=.*i)(?=.*v)(?=.*e).*$/)
                                   end }

      subject do
        game.guess = 'live'
        game.bulls = 0
        game.cows = 0
        game.guess_new_word
      end

      it 'removes all words with the same letters from dictionary' do
        words_to_be_deleted.each do |word|
          expect(game.dictionary).to include(word)
        end
        subject
        words_to_be_deleted.each do |word|
          expect(game.dictionary).to_not include(word)
        end
      end
    end
  end
end
