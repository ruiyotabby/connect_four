class Board
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
end
