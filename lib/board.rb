# frozen_string_literal: true

# prints and updates board
class Board
  attr_reader :board

  BOARD_SIZE = 8
  DARK_COLOR = 46
  LIGHT_COLOR = 47

  CHESS_PIECES = {
    black_king: "\u265A",
    black_queen: "\u265B",
    black_rook: "\u265C",
    black_bishop: "\u265D",
    black_knight: "\u265E",
    black_pawn: "\u265F",
    white_king: "\u2654",
    white_queen: "\u2655",
    white_rook: "\u2656",
    white_bishop: "\u2657",
    white_knight: "\u2658",
    white_pawn: "\u2659"
  }

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

  def piece_codes
    CHESS_PIECES
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

board = Board.new
board.board[0][0][1] = board.piece_codes[:white_bishop]
board.board[0][1][1] = board.piece_codes[:white_queen]
board.board[1][0][1] = board.piece_codes[:black_knight]
board.board[1][1][1] = board.piece_codes[:black_pawn]

board.draw_board

puts "\u265A"  # Should display the white king correctly
puts "\u2654"  # Should display the black king correctly
