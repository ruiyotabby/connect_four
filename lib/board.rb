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
    grid = board.dup
    grid.each do |row|
      arr = row.each_cons(4).find { |a| a.uniq.size == 1 && a.first != "\u25ef" }
      return arr.first unless arr.nil?
    end
    nil
  end

  def check_column
    grid = board.dup
    check_row(grid.transpose)
  end

  def check_diagonal(board = @board)
    grid = board.dup
    check_row((1..grid.size-1-4).map do |i|
      (0..grid.size-2-i).map { |j| grid[i+j][j] }
    end.concat((0..grid[1].size-4).map do |j|
      (1..grid.size-j-2).map { |i| grid[i][i+j] }
    end))
  end

  def check_antidiagonal
    # grid = board.dup
    no_column = board.first.size
    grid = (board.each_index.with_object([]) do |i, a|
      a << no_column.times.map { |j| board[j][no_column-1-i] }
    end)
    check_diagonal(grid)
  end
end
