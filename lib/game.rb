require './lib/board'

class Game
  def initialize
    @board = Board.new
  end

  def play
    welcome_display
    view_board
    input_display
  end

  def welcome_display
    print 'Welome to Connect Four. It\'s a game where each player takes turns dropping pieces into the cage. '
    print 'Players win if they manage to get 4 of their pieces consecutively in a row, column or along a diagonal. '
    puts "The rules are fairly straight_forward, each player will enter a column number for the piece to be dropped at.\n"
  end

  def view_board
    board = @board.board
    board.each do |row|
      7.times do |i|
        print "\t#{row[i]}"
        puts "\n\n" if i == 6
      end
    end
  end

  def input_display
    42.times do
      @board.add_piece("\e[34m\u2b24\e[0m", player_turn('Player 1', 'blue') - 1)
      view_board
      break unless game_over.nil?

      @board.add_piece("\e[35m\u2b24\e[0m", player_turn('Player 2', 'red') - 1)
      view_board
      break unless game_over.nil?
    end
    return display_winner(game_over) if game_over

    puts 'There was a tie'
  end

  def game_over
    return @board.check_row || @board.check_column || @board.check_diagonal || @board.check_antidiagonal
  end

  def display_winner(color)
    puts color == "\e[34m\u2b24\e[0m" ? "\t\tGame Over! Player1 wins" : "\t\tGame Over! Player2 wins"
  end

  def player_turn(player, colour)
    loop do
      print "#{player} to enter number, from 1 to 7, to drop a #{colour} piece to the cage number: "
      input = verify_input(gets.to_i)
      return input if input

      print 'FAILED!!! '
    end
  end

  def verify_input(input)
    return input if input >= 1 && input <= 7
  end
end

Game.new.play
