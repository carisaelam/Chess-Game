# frozen_string_literal: true

require_relative '../piece'
require_relative '../board'

# specifics for queen pieces
class Queen < Piece
  def unicode_symbol
    color == :white ? "\u2655" : "\u265B"
  end

  def valid_move?(start_position, end_position)
    all_valid_moves(start_position).include?(end_position)
  end

  def all_valid_moves(position)
    row, col = position

    bishop_moves(row, col) + rook_moves(row, col)
  end

  private

  def bishop_moves(row, col)
    directions = [[1, 1], [-1, -1], [1, -1], [-1, 1]]
    directions.flat_map { |row_change, col_change| generate_moves(row, col, row_change, col_change) }
  end

  def rook_moves(row, col)
    directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    directions.flat_map { |row_change, col_change| generate_moves(row, col, row_change, col_change) }
  end

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
