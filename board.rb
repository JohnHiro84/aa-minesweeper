require_relative 'tile'

class Board

  def initialize

    grid = Array.new(9){[]}
    i = 0
    grid.each do |array|

      j = 0
      9.times do
        array << Tile.new([i, j])
        j+=1
      end
      i+=1
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
    mines = 3
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

  def give_tiles_board_access
    self.grid.each do |row|
      row.each do |obj|
        obj.tile_grid = self.grid
      end
    end
  end

  def print_board
    i = 0
    print "  0 1 2 3 4 5 6 7 8\n"
    grid.each do |row|
      print i.to_s + " "
      row.each do |obj|
        print obj.hidden_value.to_s + " "
      end
      i+=1
      print "\n"
    end
  end

  def print_hidden_board
    i = 0
    print "  0 1 2 3 4 5 6 7 8\n"
    grid.each do |row|
      print i.to_s + " "
      row.each do |obj|


        if obj.revealed == true
          print obj.hidden_value.to_s + " "
        elsif obj.revealed == false && obj.flag == false
          print "^" + " "
        elsif obj.revealed == false && obj.flag == true
          print "f" + " "
        end
      end
      i+=1
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
