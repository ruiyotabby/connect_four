require './lib/board'

describe Board do
  describe '#make_board' do
    subject(:game_board) { described_class.new }
    context 'when method is called' do
      it 'should return 2d array whose row length is 8' do
        expect(game_board.board.length).to eq 8
      end
      it 'should return 2d array whose column length is 7' do
        expect(game_board.board[1].length).to eq 7
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
    let(:red) { "\e[35m\u2b24\e[0m" }
    let(:blue) { "\e[34m\u2b24\e[0m" }
    context 'when player1 gets 4 pieces in the same row' do
      it 'returns blue' do
        4.times do |i|
          game_row.add_piece(blue, i)
        end
        expect(game_row.check_row).to eq blue
      end
    end
    context 'when no player has any piece in a row' do
      it 'returns nil' do
        expect(game_row.check_row).to eq nil
      end
    end
    context 'when player2 has 3 pieces in a row' do
      it 'returns nil' do
        3.times do |i|
          game_row.add_piece(red, i)
        end
        expect(game_row.check_row).to eq nil
      end
    end
  end

  describe '#check_column' do
    subject(:game_column) { described_class.new }
    let(:red) { "\e[35m\u2b24\e[0m" }
    let(:blue) { "\e[34m\u2b24\e[0m" }
    context 'when player2 gets 4 pieces in the one column' do
      it 'returns red' do
        4.times do
          game_column.add_piece(red, 2)
        end
        expect(game_column.check_column).to eq red
      end
    end
    context 'when player1 has 3 pieces in a column' do
      it 'returns nil' do
        3.times do
          game_column.add_piece(blue, 5)
        end
        expect(game_column.check_column).to eq nil
      end
    end
    context 'when no player has any piece in a column' do
      it 'returns nil' do
        expect(game_column.check_column).to eq nil
      end
    end
  end

  describe '#check_diagonal' do
    subject(:game_diagonal) { described_class.new }
    let(:red) { "\e[35m\u2b24\e[0m" }
    let(:blue) { "\e[34m\u2b24\e[0m" }
    context 'when player1 enters 4 pieces diagonally' do
      it 'returns blue' do
        allow(game_diagonal).to receive(:check_piece).and_return(3, 4, 5, 6)
        (2..5).each { |i| game_diagonal.add_piece(blue, i) }
        expect(game_diagonal.check_diagonal).to eq blue
      end
    end
    context 'when player 2 enters 3 pieces diagonally' do
      it 'returns nil' do
        allow(game_diagonal).to receive(:check_piece).and_return(4, 5, 6)
        (3..5).each { |i| game_diagonal.add_piece(red, i) }
        expect(game_diagonal.check_diagonal).to eq nil
      end
    end
    context 'when no piece has been dropped to the board' do
      it 'returns nil' do
        expect(game_diagonal.check_diagonal).to eq nil
      end
    end
    context 'when player2 has entered 4 pieces diagonally from the first row' do
      it 'returns red' do
        allow(game_diagonal).to receive(:check_piece).and_return(1, 2, 3, 4)
        (2..5).each { |i| game_diagonal.add_piece(red, i) }
        expect(game_diagonal.check_diagonal).to eq red
      end
    end
  end

  describe '#check_antidiagonal' do
    subject(:game_antidiagonal) { described_class.new }
    let(:red) { "\e[35m\u2b24\e[0m" }
    let(:blue) { "\e[34m\u2b24\e[0m" }
    context 'when player2 enters 4 pieces in antidiagonal' do
      it 'returns red' do
        allow(game_antidiagonal).to receive(:check_piece).and_return(6, 5, 4, 3)
        4.times { |i| game_antidiagonal.add_piece(red, i) }
        expect(game_antidiagonal.check_antidiagonal).to eq red
      end
    end
    context 'when player1 enters 3 pieces antidiagonally' do
      it 'returns nil' do
        allow(game_antidiagonal).to receive(:check_piece).and_return(6, 5, 4)
        4.times { |i| game_antidiagonal.add_piece(blue, i) }
        expect(game_antidiagonal.check_antidiagonal).to eq nil
      end
    end
    context 'when no piece has been dropped to the board' do
      it 'returns nil' do
        expect(game_antidiagonal.check_antidiagonal).to eq nil
      end
    end
  end
end
