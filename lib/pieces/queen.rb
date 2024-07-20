require_relative '../piece'
require_relative '../board'

class Queen < Piece
  def unicode_symbol
    if color == :white
      "\u2655"
    else
      "\u265B"
    end
  end

  def to_s
    "#{color.capitalize} #{self.class} #{position} - INSTANCE"
  end

  def valid_move?(start_position, end_position)
    row, col = start_position

    # bishop moves
    up_right_moves = generate_moves(row, col, 1, 1)
    down_left_moves = generate_moves(row, col, -1, -1)
    up_left_moves = generate_moves(row, col, 1, -1)
    down_right_moves = generate_moves(row, col, -1, 1)

    # rook moves
    right_moves = generate_moves(row, col, 0, 1)
    left_moves = generate_moves(row, col, 0, -1)
    down_moves = generate_moves(row, col, 1, 0)
    up_moves = generate_moves(row, col, -1, 0)

    all_moves = up_right_moves + down_left_moves + up_left_moves + down_right_moves + right_moves + left_moves + up_moves + down_moves

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
    p "valid moves include #{moves}"
    moves
  end

  def in_bounds?(position)
    position.all? { |coord| coord.between?(0, 7) }
  end
end
