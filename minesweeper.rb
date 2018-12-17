require_relative 'board'

class Minesweeper

  def initialize
    @board = Board.new()
    @board.place_random_mines
    @board.give_tiles_board_access
  end
  attr_accessor :board


  def guess
    puts "place your guess from the board, seperated by a comma (0, 3)"
    puts "In the second prompt indicate r (to reveal the square)"
    puts "or f (to flag the square)"

    user_guess = gets.chomp
    array_guess = user_guess.split(",")
    positions = array_guess.map { |e| e.strip.to_i  }

    user_choice = gets.chomp

    if user_choice == "r"
      puts board.[](positions).hidden_value
    elsif user_choice == "f"
      puts "flag the mine"
    end
    #puts board.print_board


    if board.[](positions).hidden_value == "m"
      puts "you hit a mine, game over"
      board.[](positions).revealed = true
      game_over? == true

    elsif board.[](positions).hidden_value == "^"


      if board.[](positions).neighhbor_bomb_count == 0
        board.[](positions).hidden_value = " "

      elsif board.[](positions).neighhbor_bomb_count > 0
        board.[](positions).hidden_value = board.[](positions).neighhbor_bomb_count.to_s
      end
      board.[](positions).revealed = true
    end
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
      p "game over"
      true
    end
    false
  end


end


sweep = Minesweeper.new
#puts sweep.board.[]([0,0]).hidden_value
#sweep.board.give_tiles_board_access
#puts sweep.board.[]([0,0]).tile_grid
#sweep.board.print_board
puts


# sweep.board[0][0].neighhbor_bomb_count
#
# sweep.board.print_board
#sweep.board.print_board
#p sweep.game_over?
# sweep.guess
#puts sweep.all_non_mine_tiles_revealed?

#sweep.board.[]([0,0]).print_board_from_tile
#puts sweep.board.[]([8,8]).neighhbor_bomb_count
#
until sweep.game_over? == true
   sweep.board.print_hidden_board
   sweep.guess
 end
