# frozen_string_literal: true

require_relative './piece_mover'
require_relative './piece'
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

  def place_piece(piece, position)
    @board[position[0]][position[1]][1] = piece
  end

  def piece_at(position)
    raise ArgumentError, 'Invalid position' unless valid_position?(position)

    @board[position[0]][position[1]]
  end

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
  end

  private

  # knight = Knight.new(:white, [0, 4])
  # place_piece(knight, [0, 3])

  # sets pieces in their starting positions based on color
  def setup_pieces(color)
    back_row = color == :black ? 0 : 7
    front_row = color == :black ? 1 : 6
    place_piece(Rook.new(color, [back_row, 0]), [back_row, 0])
    place_piece(Knight.new(color, [back_row, 1]), [back_row, 1])
    place_piece(Bishop.new(color, [back_row, 2]), [back_row, 2])
    place_piece(Queen.new(color, [back_row, 3]), [back_row, 3])
    place_piece(King.new(color, [back_row, 4]), [back_row, 4])
    place_piece(Bishop.new(color, [back_row, 5]), [back_row, 5])
    place_piece(Knight.new(color, [back_row, 6]), [back_row, 6])
    place_piece(Rook.new(color, [back_row, 7]), [back_row, 7])

    BOARD_SIZE.times { |i| place_piece(Pawn.new(color, [front_row, i]), [front_row, i]) }
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

  # Returns the ANSI color code for the dark squares on the board
  def dark
    DARK_COLOR
  end

  # Returns the ANSI color code for the lights squares on the board
  def light
    LIGHT_COLOR
  end

  # Returns a hash of Unicode symbols representing the chess pieces.
  def chess_pieces
    CHESS_PIECES
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
  def square(color, piece = ' ')
    [color, piece]
  end

  # assigns color to a square base on index and row_order
  def color_for_square(index, row_order)
    if (row_order == 'odd' && index.even?) || (row_order != 'odd' && index.odd?)
      dark
    else
      light
    end
  end

  # Builds a row of squares alternating colors based on row order
  def build_row(row_order)
    Array.new(BOARD_SIZE) { |i| square(color_for_square(i, row_order)) }
  end
end
