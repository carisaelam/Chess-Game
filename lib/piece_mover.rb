# frozen_string_literal: true

class PieceMover
  def initialize(board)
    @board = board
  end

  # copies start_position piece onto the end_position piece
  def move_piece(start_position, end_position)
    return nil if check_in_bounds(end_position) == false

    return nil if end_point(end_position) != ' '

    set_pieces(start_position, end_position)
    clear_pieces(start_position)
  end

  private

  # check if position is on the board
  def check_in_bounds(position)
    position[0].between?(0, 7) && position[1].between?(0, 7)
  end

  # return start_position from board
  def start_point(start_position)
    @board.board[start_position[0]][start_position[1]][1]
  end

  # return end_position from board
  def end_point(end_position)
    @board.board[end_position[0]][end_position[1]][1]
  end

  def set_pieces(start_position, end_position)
    @board.board[end_position[0]][end_position[1]][1] = @board.board[start_position[0]][start_position[1]][1]
  end

  # clears piece from start_position
  def clear_pieces(start_position)
    @board.board[start_position[0]][start_position[1]][1] = ' '
  end
end
