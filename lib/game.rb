require './lib/board'

class Game
  def initialize
    @board = Board.new.make_board
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
    @board.each do |row|
      7.times do |i|
        print "\t#{row[i]}"
        puts "\n\n" if i == 6
      end
    end
  end

  def verify_input(input)
    return input if input >= 1 && input <= 7
  end
end

# Game.new.play
