# frozen_string_literal: true

require_relative '../piece'

# specifics for pawn pieces
class Pawn < Piece
  def unicode_symbol
    if color == :white
      "\u2659"
    else
      "\u265F"
    end
  end

  def valid_move?(start_position, end_position)
    all_moves = all_valid_moves(start_position)

    all_moves.include?(end_position)
  end

  def all_valid_moves(position)
    generate_moves(position)
  end

  private

  def generate_moves(start_position)
    row, col = start_position
    moves = []

    forward = color == :white ? [row - 1, col] : [row + 1, col]
    double_forward = color == :white ? [row - 2, col] : [row + 2, col]
    left_diagonal = color == :white ? [row - 1, col - 1] : [row + 1, col + 1]
    right_diagonal = color == :white ? [row - 1, col + 1] : [row + 1, col - 1]

    # allow for two moves forward on first turn for each piece only
    if (row == 6 && color == :white) || (row == 1 && color == :black)
      add_valid_move(moves, double_forward, :empty,
                     enemy_check: false)
    end

    add_valid_move(moves, forward, :empty, enemy_check: false)
    add_valid_move(moves, left_diagonal, color, enemy_check: true)
    add_valid_move(moves, right_diagonal, color, enemy_check: true)

    moves
  end

  def add_valid_move(moves, position, _color_check, enemy_check: false)
    return unless in_bounds?(position)

    piece_color = board.piece_at(position).color

    if enemy_check
      moves << position if piece_color != color && piece_color != :empty
    elsif piece_color == :empty
      moves << position
    end
  end
end
