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
  }.freeze

  def initialize
    @board = initialize_board
  end

  def draw_board
    build_letter_rows
    board.each do |row|
      row.each { |square| print print_square(square) }
      puts
    end
  end

  def starting_positions
    # black pieces (top)
    board[0][0][1] = piece_codes[:black_rook]
    board[0][1][1] = piece_codes[:black_knight]
    board[0][2][1] = piece_codes[:black_bishop]
    board[0][3][1] = piece_codes[:black_queen]
    board[0][4][1] = piece_codes[:black_king]
    board[0][5][1] = piece_codes[:black_bishop]
    board[0][6][1] = piece_codes[:black_knight]
    board[0][7][1] = piece_codes[:black_rook]
    board[1][0][1] = piece_codes[:black_pawn]
    board[1][1][1] = piece_codes[:black_pawn]
    board[1][2][1] = piece_codes[:black_pawn]
    board[1][3][1] = piece_codes[:black_pawn]
    board[1][4][1] = piece_codes[:black_pawn]
    board[1][5][1] = piece_codes[:black_pawn]
    board[1][6][1] = piece_codes[:black_pawn]
    board[1][7][1] = piece_codes[:black_pawn]

    # white pieces (bottom)
    board[7][0][1] = piece_codes[:white_rook]
    board[7][1][1] = piece_codes[:white_knight]
    board[7][2][1] = piece_codes[:white_bishop]
    board[7][3][1] = piece_codes[:white_queen]
    board[7][4][1] = piece_codes[:white_king]
    board[7][5][1] = piece_codes[:white_bishop]
    board[7][6][1] = piece_codes[:white_knight]
    board[7][7][1] = piece_codes[:white_rook]
    board[7][7][1] = piece_codes[:white_rook]
    board[6][0][1] = piece_codes[:white_pawn]
    board[6][1][1] = piece_codes[:white_pawn]
    board[6][2][1] = piece_codes[:white_pawn]
    board[6][3][1] = piece_codes[:white_pawn]
    board[6][4][1] = piece_codes[:white_pawn]
    board[6][5][1] = piece_codes[:white_pawn]
    board[6][6][1] = piece_codes[:white_pawn]
    board[6][7][1] = piece_codes[:white_pawn]
  end

  def move_piece(start_position, end_position)
    # copies start_position piece onto the end_position piece
    board[end_position[0]][end_position[1]][1] = board[start_position[0]][start_position[1]][1]

    # clears piece from start_position
    board[start_position[0]][start_position[1]][1] = ' '
  end

  private

  def build_letter_rows
    print " a  b  c  d  e  f  g  h\n"
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
end

# board = Board.new
# board.starting_positions
# pp board.board

# # MOVING PIECES...

# # copies piece to goal square
# board.board[5][0][1] = board.board[6][0][1]

# # clears start square of piece
# board.board[6][0][1] = ' '

# pp board.board
# board.draw_board
