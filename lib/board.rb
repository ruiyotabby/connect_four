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
    arr
  end

  def check_piece(place)
    empty_circle = "\u25ef"
    (1..6).each do |i|
      return i - 1 if board[i][place] != empty_circle
    end
    6
  end

  def add_piece(color, column)
    row = check_piece(column)
    return puts 'Failed, column already filled' if row.zero?

    @board[row][column] = color
  end

  def check_row(board = @board)
    (1..6).each do |row|
      arr = board[row].each_cons(4).find { |a| a.uniq.size == 1 && a.first != "\u25ef" }
      return arr.first unless arr.nil?
    end
    nil
  end

  def check_column
    check_row(board.transpose)
  end
end
