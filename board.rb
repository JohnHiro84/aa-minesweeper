require_relative 'tile'

require 'colorized_string'

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

  def give_tiles_board_access
    self.grid.each do |row|
      row.each do |obj|
        obj.tile_grid = self.grid
      end
    end
  end

  def print_board
    i = 0
    #print "  0 1 2 3 4 5 6 7 8\n"
    print easy_color("  0 1 2 3 4 5 6 7 8\n", :green)
    grid.each do |row|
      #print i.to_s + " "
      row_num_color = i.to_s + " "
      print easy_color(row_num_color, :green)
      row.each do |obj|
        if obj.hidden_value == "m"
          print easy_color(obj.hidden_value, :red)
          print " "
        else
          print obj.hidden_value.to_s + " "
        end
      end
      i+=1
      print "\n"
    end
  end

  def print_hidden_board
    i = 0
    #print "  0 1 2 3 4 5 6 7 8\n"
    print easy_color("  0 1 2 3 4 5 6 7 8\n", :green)
    grid.each do |row|
      #print i.to_s + " "
      row_num_color = i.to_s + " "
      print easy_color(row_num_color, :green)
      row.each do |obj|

        if obj.revealed == true
          num_values = "12345678"
          if num_values.include?(obj.hidden_value) == true
            #print ColorizedString[obj.hidden_value].colorize(:yellow) + " "
            print easy_color(obj.hidden_value, :yellow)
            print " "
          elsif obj.hidden_value == "m"
            print easy_color(obj.hidden_value, :red)
            print " "
          else
            print obj.hidden_value.to_s + " "
          end

        elsif obj.revealed == false && obj.flag == false
          print "^" + " "
        elsif obj.revealed == false && obj.flag == true
          print easy_color("f", :blue)
          print " "
        end
      end
      i+=1
      print "\n"
    end
  end

  def easy_color(string, color)
     ColorizedString[string].colorize(color)
  end

end
