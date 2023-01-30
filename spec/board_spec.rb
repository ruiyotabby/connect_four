require './lib/board'

describe Board do
  describe '#make_board' do
    subject(:game_board) { described_class.new }
    context 'when method is called' do
      it 'should return 2d array whose length is 8' do
        expect(game_board.board.length).to eq 8
      end
    end
  end

  describe '#add_piece' do
    subject(:game_add) { described_class.new }
    let(:blue) { "\e[34m\u2b24\e[0m" }

    context 'when the column is filled with pieces' do
      it 'returns an error' do
        error = 'Failed, column already filled'
        allow(game_add).to receive(:check_piece).and_return 0
        expect(game_add).to receive(:puts).with(error).once
        game_add.add_piece(blue, 6)
      end
    end
    context 'when column is not filled' do
      it 'adds the player\'s piece to the board' do
        allow(game_add).to receive(:check_piece).and_return 6
        game_add.add_piece(blue, 4)
        expect(game_add.board[6][4]).to eq blue
      end
    end
  end
end
