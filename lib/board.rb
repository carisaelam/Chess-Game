# frozen_string_literal: true

require_relative 'piece_mover'
require_relative 'piece'

# prints and updates board
class Board
  private

  attr_reader :board

  public

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
    starting_positions
    @piece_mover = PieceMover.new(self)
  end

  # calls check_castle_move for short castle
  def castle_short_move_available?(color)
    check_castle_move(color, short: true)
  end

  # calls check_castle_move for long castle
  def castle_long_move_available?(color)
    check_castle_move(color, short: false)
  end

  # helper method for pawn promotion
  def promotion_possible?(color, end_position)
    promotion_row = color == :black ? 7 : 0
    end_position[0] == promotion_row
  end

  # places piece on board at given position and updates its position variable
  def place_piece(piece, new_position)
    raise "Expected Piece, got #{piece.class}" unless piece.is_a?(Piece)

    @board[new_position[0]][new_position[1]][1] = piece
    piece.update_position(new_position)
  end

  # returns the piece at a given position
  def piece_at(position)
    raise ArgumentError, 'Invalid position' unless valid_position?(position)

    board[position[0]][position[1]][1]
  end

  # checks that position is an array and is on the board
  def valid_position?(position)
    position.is_a?(Array) && position.length == 2 && position.all? do |coord|
      coord.is_a?(Integer) && coord.between?(0, 7)
    end
  end

  # prints a drawn board between two rows of letters
  def print_board
    print "  A  B  C  D  E  F  G  H\n"
    draw_board
    print "  A  B  C  D  E  F  G  H\n"
  end

  # creates all of the board squares
  def draw_board
    board.each_with_index do |row, index|
      create_row(row, index)
      puts
    end
  end

  # scripts setup black and setup white
  def starting_positions
    setup_pieces(:black)
    setup_pieces(:white)
    setup_pieces(:empty)
  end

  private

  # checks if a castle move is available
  def check_castle_move(color, short:)
    row = color == :white ? 7 : 0
    king_col = 4
    rook_col = short ? 7 : 0
    empty_cols = short ? [6, 5] : [1, 2, 3]

    rook_valid?(color, row, rook_col) &&
      empty_cols.all? { |col| empty?(row, col) } &&
      king_valid?(color, row, king_col)
  end

  # helper method for check_castle_move
  def rook_valid?(color, row, col)
    piece_at([row, col]).color == color &&
      piece_at([row, col]).instance_of?(Rook)
  end

  # helper method for check_castle_move
  def empty?(row, col)
    piece_at([row, col]).color == :empty
  end

  # helper method for check_castle_move
  def king_valid?(color, row, col)
    piece_at([row, col]).color == color &&
      piece_at([row, col]).instance_of?(King)
  end

  # sets pieces in their starting positions based on color
  def setup_pieces(color)
    back_row, front_row = case color
                          when :black then [0, 1]
                          when :white then [7, 6]
                          else return
                          end

    place_back_row_pieces(color, back_row)
    place_pawns(color, front_row)
    fill_empty_pieces
  end

  # places correct color pawns on correct row depending on color
  def place_pawns(color, front_row)
    BOARD_SIZE.times { |i| place_piece(Pawn.new(color, [front_row, i], self), [front_row, i]) }
  end

  # places correct pieces on back row depending on color
  def place_back_row_pieces(color, back_row)
    piece_classes = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    piece_classes.each_with_index do |piece_class, i|
      place_piece(piece_class.new(color, [back_row, i], self), [back_row, i])
    end
  end

  # fills rows 2-5 with empty pieces
  def fill_empty_pieces
    [2, 3, 4, 5].each do |row|
      BOARD_SIZE.times { |i| place_piece(EmptyPiece.new, [row, i]) }
    end
  end

  # creates a row of squares in between two rows of numbers
  def create_row(row, index)
    print (index - BOARD_SIZE).abs # prints numbers in descending order as on a chess board
    row.each { |square| print print_square(square) }
    print (index - BOARD_SIZE).abs
  end

  # Initializes the board with rows built according to their even or odd index
  def initialize_board
    Array.new(BOARD_SIZE) { |i| build_row(i.even? ? 'even' : 'odd') }
  end

  # formats and prints one square
  def print_square(square)
    color = square[0]

    piece_code = if square[1].is_a?(Piece)
                   square[1].unicode_symbol
                 else
                   square[1]
                 end
    "\e[#{color}m #{piece_code} \e[0m"
  end

  # creates a square with given color and piece
  def square(color, piece = EmptyPiece.new)
    [color, piece]
  end

  # assigns color to a square base on index and row_order
  def color_for_square(index, row_order)
    if (row_order == 'odd' && index.even?) || (row_order != 'odd' && index.odd?)
      DARK_COLOR
    else
      LIGHT_COLOR
    end
  end

  # Builds a row of squares alternating colors based on row order
  def build_row(row_order)
    Array.new(BOARD_SIZE) { |i| square(color_for_square(i, row_order)) }
  end
end
