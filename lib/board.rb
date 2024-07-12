# frozen_string_literal: true

# prints and updates board
class Board
  attr_reader :board

  BOARD_SIZE = 8
  DARK_COLOR = 46
  LIGHT_COLOR = 47

  def initialize
    @board = initialize_board
  end

  def initialize_board
    built_board = []

    BOARD_SIZE.times do |i|
      row_order = i.even? ? 'even' : 'odd'
      built_board << build_row(row_order)
    end

    built_board
  end

  def dark
    DARK_COLOR
  end

  def light
    LIGHT_COLOR
  end

  def print_square(square)
    "\e[#{square[0]}m #{square[1]} \e[0m"
  end

  def square(color, piece = ' ')
    [color, piece]
  end

  def color_for_square(index, row_order)
    if (row_order == 'odd' && index.even?) || (row_order != 'odd' && index.odd?)
      dark
    else
      light
    end
  end

  def build_row(row_order)
    row = []

    BOARD_SIZE.times do |i|
      color = color_for_square(i, row_order)
      row << square(color)
    end

    row
  end

  def draw_board
    board.each do |row|
      row.each { |square| print print_square(square) }
      puts
    end
  end
end

# board = Board.new
# pp board
# board.draw_board
