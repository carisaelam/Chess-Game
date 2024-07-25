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
    all_moves = all_valid_moves(start_position)

    # ultimately says whether move is valid
    all_moves.include?(end_position)
  end

  # lists all valid move options on board
  def all_valid_moves(position)
    row, col = position
    # last two numbers describe how row/col changes
    right_moves = generate_moves(row, col, 0, 1)
    left_moves = generate_moves(row, col, 0, -1)
    down_moves = generate_moves(row, col, 1, 0)
    up_moves = generate_moves(row, col, -1, 0)

    left_moves + right_moves + down_moves + up_moves
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
    check_for_castle
    moves
  end

  def check_for_castle
    castle_short_available?(other_color) if castle_short_move_available?
    castle_long_available?(other_color) if castle_long_move_available?
  end

  def other_color
    other_color = color == :white ? :black : :white
  end

  def castle_short_move_available?
    # p "'castle_short_move_available running'on #{other_color}"
    castle_short_move_white || castle_short_move_black
  end

  def castle_long_move_available?
    # p " 'castle_long_move_available running on #{other_color}'"
    castle_long_move_white || castle_long_move_black
  end

  def castle_short_move_white
    # p "'castle_short_move_white running on #{other_color}'"
    board.piece_at([7, 7]).color == :white && board.piece_at([7, 7]).instance_of?(Rook) &&
      board.piece_at([7, 6]).color == :empty &&
      board.piece_at([7, 5]).color == :empty &&
      board.piece_at([7, 4]).color == :white && board.piece_at([7, 4]).instance_of?(King)
  end

  def castle_short_move_black
    # p "castle_short_move_black running on #{other_color}'"
    board.piece_at([0, 7]).color == :black && board.piece_at([0, 7]).instance_of?(Rook) &&
      board.piece_at([0, 6]).color == :empty &&
      board.piece_at([0, 5]).color == :empty &&
      board.piece_at([0, 4]).color == :black && board.piece_at([0, 4]).instance_of?(King)
  end

  def castle_long_move_white
    # p "'castle_long_move_white running on #{other_color}'"
    board.piece_at([7, 0]).color == :white && board.piece_at([7, 0]).instance_of?(Rook) &&
      board.piece_at([7, 1]).color == :empty &&
      board.piece_at([7, 2]).color == :empty &&
      board.piece_at([7, 3]).color == :empty &&
      board.piece_at([7, 4]).color == :white && board.piece_at([7, 4]).instance_of?(King)
  end

  def castle_long_move_black
    # p "'castle_long_move_black running on #{other_color}'"
    board.piece_at([0, 0]).color == :black && board.piece_at([0, 0]).instance_of?(Rook) &&
      board.piece_at([0, 1]).color == :empty &&
      board.piece_at([0, 2]).color == :empty &&
      board.piece_at([0, 3]).color == :empty &&
      board.piece_at([0, 4]).color == :black && board.piece_at([0, 4]).instance_of?(King)
  end
end
