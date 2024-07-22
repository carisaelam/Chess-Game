# frozen_string_literal: true

require_relative '../piece'
require_relative '../board'

class Rook < Piece
  def unicode_symbol
    if color == :white
      "\u2656"
    else
      "\u265C"
    end
  end

  def valid_move?(start_position, end_position)
    row, col = start_position

    # last two numbers describe how row/col changes
    right_moves = generate_moves(row, col, 0, 1)
    left_moves = generate_moves(row, col, 0, -1)
    down_moves = generate_moves(row, col, 1, 0)
    up_moves = generate_moves(row, col, -1, 0)

    all_moves = left_moves + right_moves + down_moves + up_moves

    # ultimately says whether move is valid
    all_moves.include?(end_position)
  end

  private

  def generate_moves(row, col, row_change, col_change)
    moves = []
    (1..7).each do |step|
      new_row = row + step * row_change
      new_col = col + step * col_change
      next_move = [new_row, new_col]

      break unless in_bounds?(next_move)

      piece = @board.piece_at(next_move)
      break if color == piece.color

      moves << next_move
      # captures an enemy piece then stops
      break unless piece.color == :empty
    end
    moves
  end
end
