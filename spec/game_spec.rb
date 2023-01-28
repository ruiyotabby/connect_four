require './lib/game'

describe Game do
  describe '#verify-input' do
    subject(:game_verify) { described_class.new }
    context 'when method is called with right input' do
      it 'should return number input' do
        expect(game_verify.verify_input(4)).to eq 4
      end
    end
    context 'when method is called with input out of range' do
      it 'returns nil' do
        expect(game_verify.verify_input(9)).to eq nil
      end
    end
  end

end
