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

  describe '#check_piece' do
    subject(:game_check) { described_class.new }
    let(:red) { "\e[35m\u2b24\e[0m" } 
    context 'when the column is empty' do
      it 'returns 6' do
        expect(game_check.check_piece(4)).to eq 6
      end
    end
    context 'when column is full' do
      it 'returns 0' do
        6.times { game_check.add_piece(red, 5) }
        expect(game_check.check_piece(5)).to eq 0
      end
    end
    context 'when column is half empty' do
      it 'returns 3' do
        3.times { game_check.add_piece(red, 2) }
        expect(game_check.check_piece(2)).to eq 3
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

  describe '#check_row' do
    subject(:game_row) { described_class.new }
    context 'when player1 gets 4 pieces in the same row' do
      it 'returns blue' do
        blue = "\e[34m\u2b24\e[0m"
        4.times do |i|
          game_row.add_piece(blue, i)
        end
        expect(game_row.board).to eq blue
      end
    end
    context 'when no player gets 4 pieces in a row' do
      it 'returns nil' do
        expect(game_row.check_row).to eq nil
      end
    end
  end
end
