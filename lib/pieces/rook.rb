# frozen_string_literal: true

require_relative '../piece'
require_relative '../board'

# specifics for rook pieces
class Rook < Piece
  def unicode_symbol
    if color == :white
      "\u2656"
    else
      "\u265C"
    end
  end

  def valid_move?(start_position, end_position)
    all_moves = all_valid_moves(start_position)

    # ultimately says whether move is valid
    all_moves.include?(end_position)
  end

  # lists all valid move options on board
  def all_valid_moves(position)
    row, col = position
    # last two numbers describe how row/col changes
    right_moves = generate_moves(row, col, 0, 1)
    left_moves = generate_moves(row, col, 0, -1)
    down_moves = generate_moves(row, col, 1, 0)
    up_moves = generate_moves(row, col, -1, 0)

    left_moves + right_moves + down_moves + up_moves
  end

  private

  def generate_moves(row, col, row_change, col_change)
    (1..7).each_with_object([]) do |step, moves|
      new_row = row + (step * row_change)
      new_col = col + (step * col_change)
      next_move = [new_row, new_col]

      break moves unless in_bounds?(next_move)

      piece = @board.piece_at(next_move)
      break moves if color == piece.color

      moves << next_move
      break moves if piece.color != :empty
    end
  end
end
