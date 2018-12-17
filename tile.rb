require_relative 'board'

class Tile

  attr_accessor :hidden_value, :revealed, :flag, :tile_grid, :tile_location

  def initialize(array)
    @hidden_value = "^"
    @revealed = false
    @flag = false
    @tile_grid = {}
    @tile_location = array
  end
  # def hidden_value
  #   @hidden_value
  # end
  #
  # def hidden_value=(new_value)
  #   @hidden_value = new_value
  # end

  def neighhbor_bomb_count
    count = 0
    # puts @tile_location
    # puts @tile_grid[0][0].hidden_value

    row = @tile_location[0]
    col = @tile_location[1]

    if (row-1) >= 0 && (row-1) < 9
      if tile_grid[row-1][col].hidden_value == "m"
        count+=1
      end
    end

    if (row-1) >= 0 && (row-1) < 9 && (col-1) >=0 && (col-1) < 9
      if tile_grid[row-1][col-1].hidden_value == "m"
        count+=1
      end
    end

    if (col-1) >= 0 && (col-1) < 9
      if tile_grid[row][col-1].hidden_value == "m"
        count+=1
      end
    end

    if (row-1) >= 0 && (row-1) < 9 && (col+1) >=0 && (col+1) < 9
      if tile_grid[row-1][col+1].hidden_value == "m"
        count+=1
      end
    end

    if (col+1) >= 0 && (col+1) < 9
      if tile_grid[row][col+1].hidden_value == "m"
        count+=1
      end
    end

    if (row+1) >= 0 && (row+1) < 9 && (col+1) >=0 && (col+1) < 9
      if tile_grid[row+1][col+1].hidden_value == "m"
        count+=1
      end
    end

    if (row+1) >= 0 && (row+1) < 9 && (col) >=0 && (col) < 9
      if tile_grid[row+1][col].hidden_value == "m"
        count+=1
      end
    end

    if (row+1) >= 0 && (row+1) < 9 && (col-1) >=0 && (col-1) < 9
      if tile_grid[row+1][col-1].hidden_value == "m"
        count+=1
      end
    end
    count
  end

  def print_board_from_tile
    tile_grid.each do |row|
      #print row.to_s + "\n"
      row.each do |obj|
        print obj.hidden_value.to_s + " "
      end
      print "\n"
    end
  end

end

#
# tike = Tile.new
# print tike.hidden_value
# tike.hidden_value = "mop"
# print tike.hidden_value
