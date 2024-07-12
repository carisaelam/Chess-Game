class Board
  attr_accessor :board

  def initialize
    @board = build_that_board
  end

  def print_square(square)
    "\e[#{square[0]}m #{square[1]} \e[0m"
  end

  def square(color, piece = ' ')
    [color, piece]
  end

  def build_array_line(modifier)
    result = []

    8.times do |i|
      color_code = (if modifier == 'even'
                      i.even? ? 46 : 47
                    else
                      (i.odd? ? 46 : 47)
                    end)
      result << square(color_code)
    end

    result # Return the array of squares
  end

  def build_that_board
    built_board = []

    8.times do |i|
      modifier = i.even? ? 'even' : 'odd'
      built_board << build_array_line(modifier)
    end

    built_board
  end

  # Print the board
  def draw_board(board)
    board.each do |row|
      row.each { |square| print print_square(square) } # Destructure the array for print_square
      puts # Move to the next line after printing each row
    end
  end
end

# empty_board = Board.new
# board = empty_board.build_that_board

# empty_board.draw_board(board)
