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

  def check_piece(place)
    empty_circle = "\u25ef"
    (1..6).each do |i|
      return i - 1 if board[i][place] != empty_circle
    end
    return 6
  end

  def add_piece(color, column)
    row = check_piece(column)
    return puts 'Failed, column already filled' if row.zero?

    @board[row][column] = color
  end

  def check_row
    blue = "\e[34m\u2b24\e[0m"
    red = "\e[35m\u2b24\e[0m"
    player1 = player2 = 0
    (1..6).each do |row|
      7.times do |column|
        player1 += 1 if board[row][column] == blue
        player2 += 1 if board[row][column] == red
        return blue if player1 == 4
        return red if player2 == 4
      end
      player1 = player2 = 0
    end
    return nil
  end
end
