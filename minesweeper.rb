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


  def valid_input(array)
    if array == nil
      array = ["error"]
    end
    permitted_nums = "012345678"
    validated = true
    if array.any? { |e| e.length != 1}
      validated = false
    end
    if array.all? { |e| permitted_nums.include?(e)} == false
      validated = false
    end
    if array.length != 2
      validated = false
    end
    validated
  end

  def user_reveal_or_flag(array_guess)

    if valid_input(array_guess) == true
      positions = array_guess.map { |e| e.strip.to_i  }
      user_choice = gets.chomp

      if user_choice && user_choice == "r"
        check_selected_position(positions)

      elsif user_choice && user_choice == "f"
        puts "flag the mine"
        if board.[](positions).flag == true
          board.[](positions).flag = false
        elsif board.[](positions).flag == false
          board.[](positions).flag = true
        end
      end

    elsif valid_input(array_guess) == false
      user_guess = 0
      array_guess = []
      user_choice = ""
    end
  end

  def guess
    prompt_user
    user_guess = gets.chomp

    if user_guess == 'save'
      File.open("minesweeper_saved_game.yml", "w") { |file| file.write(self.to_yaml) }
      exit!
    end

    if user_guess.include?(",") == true
      array_guess = user_guess.split(",")
      array_guess = array_guess.map { |e| e.strip }

    elsif user_guess.include?(" ") == true
      array_guess = user_guess.split(" ")
    end

    user_reveal_or_flag(array_guess)

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

        elsif board.[](positions).hidden_value == "^"

          if board.[](positions).neighhbor_bomb_count == 0
            board.[](positions).hidden_value = " "
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
      print "\nCongratulations! you win!\n\n"
      self.game_over = true
    elsif hit_mine == true
      system "clear" or system "cls"
      self.board.print_hidden_board
      print "\n\n"
      self.board.print_board
      print "\nYou hit a mine, game over.\n\n"
      self.game_over = true
    end
  end

end
