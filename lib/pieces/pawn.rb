require_relative '../piece'

class Pawn < Piece
  def unicode_symbol
    if color == :white
      "\u2659"
    else
      "\u265F"
    end
  end

  def valid_move?(start_position, end_position)
    generate_moves(start_position).include?(end_position)
  end

  private

  def generate_moves(start_position)
    row, col = start_position
    moves = []

    forward = color == :white ? [row - 1, col] : [row + 1, col]
    left_diagonal = color == :white ? [row - 1, col - 1] : [row + 1, col + 1]
    right_diagonal = color == :white ? [row - 1, col + 1] : [row + 1, col - 1]

    add_valid_move(moves, forward, :empty)
    add_valid_move(moves, left_diagonal, color, true)
    add_valid_move(moves, right_diagonal, color, true)

    moves
  end

  def add_valid_move(moves, position, color_check, enemy_check = false)
    return unless valid_position?(position)

    piece_color = board.piece_at(position).color

    if enemy_check
      moves << position if piece_color != color && piece_color != :empty
    elsif piece_color == color_check
      moves << position
    end
  end

  def valid_position?(position)
    position.all? { |coord| coord.between?(0, 7) }
  end
end
