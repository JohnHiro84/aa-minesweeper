require_relative 'board'

class Minesweeper

  def initialize
    @board = Board.new()
    @board.place_random_mines

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
      game_over? == true
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


#
# sweep.board.print_board
#sweep.board.print_board
#p sweep.game_over?
# sweep.guess
#puts sweep.all_non_mine_tiles_revealed?



until sweep.game_over? == true
   sweep.board.print_board
   sweep.guess
 end
