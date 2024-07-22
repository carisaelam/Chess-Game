# frozen_string_literal: true

require_relative './piece_mover'
require_relative './piece'

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

  # DELETE THIS METHOD
  # def print_board_contents
  #   p 'PRINTING BOARD CONTENTS'
  #   board.each_with_index do |row, i|
  #     row.each_with_index do |square, j|
  #       p "Position [#{i}, #{j}] - Color: #{square[0]}, Piece: #{square[1].class}"
  #     end
  #   end
  # end

  def place_piece(piece, new_position)
    raise "Expected Piece, got #{piece.class}" unless piece.is_a?(Piece)

    @board[new_position[0]][new_position[1]][1] = piece
    piece.update_position(new_position)
  end

  def piece_at(position)
    # p "runing piece at: #{position}"
    raise ArgumentError, 'Invalid position' unless valid_position?(position)

    board[position[0]][position[1]][1]
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
    setup_pieces(:empty)
  end

  private

  # sets pieces in their starting positions based on color
  def setup_pieces(color)
    case color
    when :black
      back_row = 0
      front_row = 1
    when :white
      back_row = 7
      front_row = 6
    else
      # Skip setup if color is :empty
      return
    end
    place_piece(Rook.new(color, [back_row, 0], self), [back_row, 0])
    place_piece(Knight.new(color, [back_row, 1], self), [back_row, 1])
    place_piece(Bishop.new(color, [back_row, 2], self), [back_row, 2])
    place_piece(Queen.new(color, [back_row, 3], self), [back_row, 3])
    place_piece(King.new(color, [back_row, 4], self), [back_row, 4])
    place_piece(Bishop.new(color, [back_row, 5], self), [back_row, 5])
    place_piece(Knight.new(color, [back_row, 6], self), [back_row, 6])
    place_piece(Rook.new(color, [back_row, 7], self), [back_row, 7])

    BOARD_SIZE.times { |i| place_piece(Pawn.new(color, [front_row, i], self), [front_row, i]) }

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
    # puts "DEBUG: square=#{square.class}"
    # puts "square color is: #{square[0]}"
    # puts "square [1] is a : #{square[1].color} #{square[1].class}"
    # puts

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
