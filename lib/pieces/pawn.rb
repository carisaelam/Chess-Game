require_relative '../piece'
require_relative '../board'

class Pawn < Piece
 

  def unicode_symbol
    if color == :white
      "\u2659"
    else
      "\u265F"
    end
  end

  def valid_move?(start_position, end_position)
    row = start_position[0]
    col = start_position[1]

    moves = []

    if color == :black
      moves.push([row + 1, col])
    elsif color == :white
      moves.push([row - 1, col])
    end

    filtered_moves = filter_possible_moves(moves)
    filtered_moves.include?(end_position)
  end

  # filter out out of bounds moves
  def filter_possible_moves(moves)
    legal_moves = []

    moves.each do |move|
      next unless move[0].between?(0, 7) && move[1].between?(0, 7)

      legal_moves.push(move)
    end

    legal_moves
  end
end
