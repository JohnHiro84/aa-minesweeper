require_relative 'board'

class Minesweeper

  def initialize
    @board = Board.new()
    @board.place_random_mines
    @board.give_tiles_board_access
    @hit_mine = false
    @game_over = false
  end
  attr_accessor :board, :hit_mine


  def guess
    puts "place your guess from the board, seperated by a comma (0, 3)"
    puts "In the second prompt indicate r (to reveal the square)"
    puts "or f (to flag the square)"

    user_guess = gets.chomp
    array_guess = user_guess.split(",")
    positions = array_guess.map { |e| e.strip.to_i  }

    user_choice = gets.chomp

    if user_choice == "r"
      #puts board.[](positions).hidden_value
      check_selected_position(positions)

    elsif user_choice == "f"
      puts "flag the mine"
    end
    #puts board.print_board

  end

  def check_selected_position(positions)

        if board.[](positions).hidden_value == "m"
          puts "you hit a mine, game over"
          board.[](positions).revealed = true
          hit_mine = true
          game_over = true

        elsif board.[](positions).hidden_value == "^"

          if board.[](positions).neighhbor_bomb_count == 0
            board.[](positions).hidden_value = " "
            #print surrounding_positions(positions)
            puts
            surrounding_positions(positions).each do |pos|
              check_selected_position(pos)
            end

          elsif board.[](positions).neighhbor_bomb_count > 0
            board.[](positions).hidden_value = board.[](positions).neighhbor_bomb_count.to_s
          end
          board.[](positions).revealed = true
        end
  end

  def surrounding_positions(positions)
    #takes in 1 array, returns 8 arrays for surrounding positions
    row = positions[0]
    column = positions[1]
    surrounding_arrays = []
    if row-1 >=0 && row-1 < 9
      surrounding_arrays << [(row-1), column]
    end

    if row-1 >=0 && row-1 < 9 && column-1 >=0 && column-1 < 9
      surrounding_arrays << [(row-1), (column-1)]
    end

    if row >=0 && row < 9 && column-1 >=0 && column-1 < 9
      surrounding_arrays << [(row), (column-1)]
    end

    if row+1 >=0 && row+1 < 9 && column-1 >=0 && column-1 < 9
      surrounding_arrays << [(row+1), (column-1)]
    end

    if row+1 >=0 && row+1 < 9 && column >=0 && column < 9
      surrounding_arrays << [(row+1), (column)]
    end

    if row+1 >=0 && row+1 < 9 && column+1 >=0 && column+1 < 9
      surrounding_arrays << [(row+1), (column+1)]
    end

    if row >=0 && row < 9 && column+1 >=0 && column+1 < 9
      surrounding_arrays << [(row), (column+1)]
    end

    if row-1 >=0 && row-1 < 9 && column+1 >=0 && column+1 < 9
      surrounding_arrays << [(row-1), (column+1)]
    end
    surrounding_arrays
  end

  def all_non_mine_tiles_revealed?
    output = true
    board.grid.each do |row|
      row.each do |tile|
        if tile.hidden_value == "^"
          if tile.revealed == false
            output = false
          end
        end
      end
    end
    output
  end

  def game_over?
    if all_non_mine_tiles_revealed? == true
      p "congratulations! you win!"
      p "game over"
      true
    else
      false
    end
    if hit_mine == true
      true
    end

  end


end


sweep = Minesweeper.new
#puts sweep.board.[]([0,0]).hidden_value
#sweep.board.give_tiles_board_access
#puts sweep.board.[]([0,0]).tile_grid
#sweep.board.print_board
puts


until sweep.game_over? == true
   sweep.board.print_board
   puts
   sweep.board.print_hidden_board
   sweep.guess
   sweep.game_over?
 end
