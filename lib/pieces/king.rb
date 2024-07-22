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
    moves = []
    moves.push([row + 1, col])
    moves.push([row - 1, col])
    moves.push([row, col + 1])
    moves.push([row, col - 1])
    moves.push([row + 1, col - 1])
    moves.push([row - 1, col - 1])
    moves.push([row + 1, col + 1])
    moves.push([row - 1, col + 1])

    filtered_moves = filter_possible_moves(moves)
    filtered_moves.include?(end_position)
  end

  private

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
