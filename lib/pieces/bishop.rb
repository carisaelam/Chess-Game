require_relative '../piece'
require_relative '../board'

class Bishop < Piece
  def unicode_symbol
    if color == :white
      "\u2657"
    else
      "\u265D"
    end
  end

  def valid_move?(start_position, end_position)
    row, col = start_position

    # last two numbers describe how row/col changes
    up_right_moves = generate_moves(row, col, 1, 1)
    down_left_moves = generate_moves(row, col, -1, -1)
    up_left_moves = generate_moves(row, col, 1, -1)
    down_right_moves = generate_moves(row, col, -1, 1)

    all_moves = up_right_moves + down_left_moves + up_left_moves + down_right_moves

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

  def in_bounds?(position)
    position.all? { |coord| coord.between?(0, 7) }
  end
end
