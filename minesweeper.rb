require_relative 'board'
require 'yaml'
class Minesweeper

  def initialize
    @board = Board.new()
    @board.place_random_mines
    @board.give_tiles_board_access
    @hit_mine = false
    @game_over = false
  end
  attr_accessor :board, :hit_mine, :game_over


  def guess
    prompt_user
    user_guess = gets.chomp

    if user_guess == 'save'
      File.open("minesweeper_saved_game.yml", "w") { |file| file.write(self.to_yaml) }
      exit!
    end

    array_guess = user_guess.split(",")
    positions = array_guess.map { |e| e.strip.to_i  }

    user_choice = gets.chomp

    if user_choice == "r"
      check_selected_position(positions)

    elsif user_choice == "f"
      puts "flag the mine"
      if board.[](positions).flag == true
        board.[](positions).flag = false
      elsif board.[](positions).flag == false
        board.[](positions).flag = true
      end
    end
  end

  def prompt_user
    puts "1st prompt:"
    puts "place your guess from the board, seperated by a comma (0, 3)"
    puts "or type in 'save' to save your game for another day"
    puts " "
    puts "second prompt"
    puts "In the second prompt indicate r (to reveal the square)"
    puts "or f (to flag the square)"

  end

  def check_selected_position(positions)
        if board.[](positions).flag == true
          puts "this tile is flagged"
        elsif board.[](positions).hidden_value == "m"
          board.[](positions).revealed = true
          self.hit_mine = true
          #self.game_over = true

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
      system "clear" or system "cls"
      self.board.print_hidden_board
      puts 
      self.board.print_board
      p "congratulations! you win!"
      self.game_over = true
    elsif hit_mine == true
      system "clear" or system "cls"
      p "you hit a mine, game over"
      self.board.print_board
      self.game_over = true
    end
  end

end
