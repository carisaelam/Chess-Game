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
    row, col = start_position

    all_moves = color == :white ? generate_white_moves(start_position) : generate_black_moves(start_position)
    all_moves.include?(end_position)
  end

  private

  def generate_white_moves(start_position)
    row, col = start_position
    moves = []

    white_left_diagonal = [row - 1, col - 1]

    if board.piece_at(white_left_diagonal).color != color && board.piece_at(white_left_diagonal).color != :empty
      moves << white_left_diagonal
    end

    white_right_diagonal = [row - 1, col + 1]

    if board.piece_at(white_right_diagonal).color != color && board.piece_at(white_right_diagonal).color != :empty
      moves << white_right_diagonal
    end

    white_forward_move = [row - 1, col]

    moves << white_forward_move if board.piece_at(white_forward_move).color == :empty

    p "moves are #{moves}"
    moves
  end

  def generate_black_moves(start_position)
    row, col = start_position
    moves = []

    black_left_diagonal = [row + 1, col + 1]

    if board.piece_at(black_left_diagonal).color != color && board.piece_at(black_left_diagonal).color != :empty
      moves << black_left_diagonal
    end

    black_right_diagonal = [row + 1, col - 1]

    if board.piece_at(black_right_diagonal).color != color && board.piece_at(black_right_diagonal).color != :empty
      moves << black_right_diagonal
    end

    black_forward_move = [row + 1, col]

    moves << black_forward_move if board.piece_at(black_forward_move).color == :empty

    p "moves are #{moves}"
    moves
  end
end
