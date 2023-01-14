require './lib/board'

describe Board do
  describe '#make_board' do
    subject(:game_board) { described_class.new }
    context 'when function is called' do
      it 'should return 1d array whose length is 8' do
        expect(game_board.make_board.length).to eq 8
      end
    end
  end
end
