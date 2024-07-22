# frozen_string_literal: true

require_relative '../piece'
require_relative '../board'

class Knight < Piece
  def unicode_symbol
    if color == :white
      "\u2658"
    else
      "\u265E"
    end
  end

  def valid_move?(start_position, end_position)
    row = start_position[0]
    col = start_position[1]
    moves = generate_moves(row, col)

    in_bounds?(end_position) && moves.include?(end_position)
  end

  private

  def generate_moves(row, col)
    moves = []
    moves.push([row + 1, col + 2])
    moves.push([row - 1, col + 2])
    moves.push([row + 1, col - 2])
    moves.push([row - 1, col - 2])
    moves.push([row + 2, col + 1])
    moves.push([row - 2, col + 1])
    moves.push([row + 2, col - 1])
    moves.push([row - 2, col - 1])

    moves.select { |move| in_bounds?(move) }
  end
end
