class Board
  attr_reader :board

  def initialize
    @board = make_board
  end

  def make_board
    empty_circle = "\u25ef"
    arr = []
    8.times do |j|
      arr << []
      (1..7).each do |i|
        j.zero? || j == 7 ? arr[j] << i : arr[j] << empty_circle
      end
    end
    return arr
  end

  def add_piece(color, column)
    row = check_piece(column)
    return puts 'Failed, column already filled' if row.zero?

    @board[row][column] = color
  end
end
