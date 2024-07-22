# frozen_string_literal: true

require_relative '../piece'

class King < Piece
  def unicode_symbol
    if color == :white
      "\u2654"
    else
      "\u265A"
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
    moves.push([row + 1, col])
    moves.push([row - 1, col])
    moves.push([row, col + 1])
    moves.push([row, col - 1])
    moves.push([row + 1, col - 1])
    moves.push([row - 1, col - 1])
    moves.push([row + 1, col + 1])
    moves.push([row - 1, col + 1])

    moves.select { |move| in_bounds?(move) }
  end
end
