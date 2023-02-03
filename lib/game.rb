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

  def game_over
    @board.check_row || @board.check_column || @board.check_diagonal || @board.check_antidiagonal
  end

  def display_winner(color)
    puts color == "\e[34m\u2b24\e[0m" ? 'Game Over! Player1 wins' : 'Game Over! Player2 wins'
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

# Game.new.view_board
