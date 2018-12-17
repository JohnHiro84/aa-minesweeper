require_relative 'tile'

class Board

  def initialize

    grid = Array.new(9){[]}
    grid.each do |array|
      9.times do
        array << Tile.new
      end
    end
    @grid = grid
  end

  def grid
    @grid
  end

  def [](position)
    row, col = position
    @grid[row][col]
  end

  def []= (position, val)
    row, col = position
    @grid[row][col].hidden_value = val
  end

  def place_random_mines
    mines = 10
    i=0
    while i < mines
      rand_row = rand(0...@grid.length)
      rand_col = rand(0...@grid.length)
      pos = [rand_row, rand_col]
      if self.[](pos).hidden_value == "m"
        next
      end
      self.[]=(pos, "m")
      i+=1
    end
  end

  def print_board
    grid.each do |row|
      #print row.to_s + "\n"
      row.each do |obj|
        print obj.hidden_value.to_s + " "
      end
      print "\n"
    end
  end

  def print_hidden_board
    grid.each do |row|
      #print row.to_s + "\n"
      row.each do |obj|

        if obj.revealed == true
          print obj.hidden_value.to_s + " "
        elsif obj.revealed == false
          print "^" + " "
        end
      end
      print "\n"
    end
  end

end
#
# board = Board.new()
# board.print_board
# board.place_random_mines
# print "\n"
# #board.print_board.hidden_value
# puts
# #print board.[]([0, 0]).hidden_value
# #print board.[]=([0, 0], "m")
# puts
#
# board.print_board
# board.print_hidden_board
