# frozen_string_literal: true

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

  def validate_move(start_position, end_position)
    valid_move_for_type(start_position, end_position)
  end

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

  def valid_move_for_type(start_position, end_position)
    start_piece = start_point(start_position) # contents of start square
    return true if start_piece.valid_move?(start_position, end_position)

    false
  end

  # return start_position from board
  def start_point(start_position)
    board.piece_at(start_position)
  end

  # return end_position from board
  def end_point(end_position)
    board.piece_at(end_position)
  end

  # copies the piece from the start position to the end position
  def set_pieces(start_position, end_position)
    piece = board.piece_at(start_position)
    raise 'No piece at start position' if piece.nil?

    board.place_piece(piece, end_position)
  end
end
