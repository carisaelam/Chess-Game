# frozen_string_literal: true

# moves pieces on the board
class PieceMover
  attr_reader :board

  def initialize(board)
    @board = board
  end

  # copies start_position piece onto the end_position piece
  def move_piece(start_position, end_position)
    set_pieces(start_position, end_position)
    clear_pieces(start_position)
  end

  # clears piece from start_position
  def clear_pieces(position)
    board.place_piece(EmptyPiece.new, position)
  end

  # calls private validation method for the given move
  def validate_move(start_position, end_position)
    valid_move_for_type(start_position, end_position)
  end

  # CASTLING MOVES 
  def perform_short_castle(color)
    if color == :white
      move_piece([7, 4], [7, 6])
      move_piece([7, 7], [7, 5])
    else
      move_piece([0, 4], [0, 6])
      move_piece([0, 7], [0, 5])
    end
  end

  def perform_long_castle(color)
    if color == :white
      move_piece([7, 0], [7, 3])
      move_piece([7, 4], [7, 2])
    else
      move_piece([0, 0], [0, 3])
      move_piece([0, 4], [0, 2])
    end
  end

  private

  # routes to the valid_move? method for the piece type
  def valid_move_for_type(start_position, end_position)
    start_piece = board.piece_at(start_position)
    return true if start_piece.valid_move?(start_position, end_position)

    false
  end

  # grabs piece type from start_position and passes it to piece placing method
  def set_pieces(start_position, end_position)
    piece = board.piece_at(start_position)
    raise 'No piece at start position' if piece.nil?

    board.place_piece(piece, end_position)
  end
end
