require_relative '../lib/game_core'

describe 'Bulls and Cows Game' do
  let!(:game) { Game.new('word') }

  describe '.initialize' do
    it 'sets dictionary' do
      expect(game.dictionary).to match(DICTIONARY)
    end
  end
end
