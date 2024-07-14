# frozen_string_literal: true

require_relative './piece_mover'
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
    @piece_mover = PieceMover.new(self)
  end

  # prints a drawn board between two rows of letters
  def print_board
    build_letter_rows
    draw_board
    build_letter_rows
  end

  # creates all of the board squares
  def draw_board
    board.each_with_index do |row, index|
      create_row(row, index)
      puts
    end
  end

  def starting_positions
    setup_black_pieces
    setup_white_pieces
  end

  def move_piece(start_position, end_position)
    @piece_mover.move_piece(start_position, end_position)
  end

  private

  def setup_black_pieces
    place_piece(:black_rook, [0, 0])
    place_piece(:black_knight, [0, 1])
    place_piece(:black_bishop, [0, 2])
    place_piece(:black_queen, [0, 3])
    place_piece(:black_king, [0, 4])
    place_piece(:black_bishop, [0, 5])
    place_piece(:black_knight, [0, 6])
    place_piece(:black_rook, [0, 7])
    (0..7).each { |i| place_piece(:black_pawn, [1, i]) }
  end

  def setup_white_pieces
    place_piece(:white_rook, [7, 0])
    place_piece(:white_knight, [7, 1])
    place_piece(:white_bishop, [7, 2])
    place_piece(:white_queen, [7, 3])
    place_piece(:white_king, [7, 4])
    place_piece(:white_bishop, [7, 5])
    place_piece(:white_knight, [7, 6])
    place_piece(:white_rook, [7, 7])
    (0..7).each { |i| place_piece(:white_pawn, [6, i]) }
  end

  # helper method to place pieces on board
  def place_piece(piece_type, position)
    board[position[0]][position[1]][1] = piece_codes[piece_type]
  end

  # creates a row of squares in between two rows of numbers
  def create_row(row, index)
    print index + 1
    row.each { |square| print print_square(square) }
    print index + 1
  end

  def build_letter_rows
    print "  a  b  c  d  e  f  g  h\n"
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

board = Board.new
board.starting_positions
board.print_board
board.move_piece([6, 0], [5, 0])
board.print_board
board.move_piece([1, 0], [2, 0])
board.print_board
