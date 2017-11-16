require_relative '../lib/game_core'

describe 'Bulls and Cows Game' do
  let!(:secret_word) { 'word' }
  let!(:game) { Game.new(secret_word) }

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
end
