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

  describe '#player_turn' do
    subject(:game_turn) { described_class.new }
    context 'when player enters correct input' do
      it 'returns input' do
        allow(game_turn).to receive(:print)
        allow(game_turn).to receive(:gets).and_return '5'
        allow(game_turn).to receive(:verify_input).with(5).and_return 5
        expect(game_turn.player_turn('player 1', 'blue')).to eq 5
      end
    end
    context 'when user enter incorrect input once' do
      it 'asks for input twice from the same player' do
        allow(game_turn).to receive(:print)
        allow(game_turn).to receive(:gets).and_return('9', '5')
        allow(game_turn).to receive(:verify_input).and_return(nil, 5)
        message = 'player 1 to enter number, from 1 to 7, to drop a blue piece to the cage number: '
        expect(game_turn).to receive(:print).with(message).exactly(2).times
        game_turn.player_turn('player 1', 'blue')
      end
    end
  end

  describe '#display-winner' do
    subject(:game_winner) { described_class.new }
    let(:red) { "\e[35m\u2b24\e[0m" }
    let(:blue) { "\e[34m\u2b24\e[0m" }
    context 'when blue is passed as argument' do
      it 'displays player1 as winner' do
        message = 'Game Over! Player1 wins'
        expect(game_winner).to receive(:puts).with message
        game_winner.display_winner(blue)
      end
    end
    context 'when red is passed to it' do
      it 'displays player2 as winner' do
        message = 'Game Over! Player2 wins'
        expect(game_winner).to receive(:puts).with message
        game_winner.display_winner(red)
      end
    end
  end

  describe '#game_over' do
    subject(:game_over) { described_class.new }
    context 'when #game_over is called' do
      it 'calls #check_row in Board' do
        board = game_over.instance_variable_get(:@board)
        expect(board).to receive(:check_row).exactly(4).times
        game_over.game_over
      end
      it 'calls #check_column' do
        board = game_over.instance_variable_get(:@board)
        expect(board).to receive(:check_column).exactly(1).times
        game_over.game_over
      end
      it 'calls #check_diagonal' do
        board = game_over.instance_variable_get(:@board)
        expect(board).to receive(:check_diagonal).exactly(2).times
        game_over.game_over
      end
      it 'calls #check_antidiagonal' do
        board = game_over.instance_variable_get(:@board)
        expect(board).to receive(:check_antidiagonal).exactly(1).times
        game_over.game_over
      end
    end
  end
end
