# frozen_string_literal: true

class PieceMover
  def initialize(board)
    @board = board
  end

  def start_point(start_position)
    @board.board[start_position[0]][start_position[1]][1]
  end

  def end_point(end_position)
    @board.board[end_position[0]][end_position[1]][1]
  end

  def set_pieces(start_position, end_position)
    @board.board[end_position[0]][end_position[1]][1] = @board.board[start_position[0]][start_position[1]][1]
  end

  def clear_pieces(start_position)
    # clears piece from start_position
    @board.board[start_position[0]][start_position[1]][1] = ' '
  end

  def move_piece(start_position, end_position)
    # copies start_position piece onto the end_position piece

    return nil if end_point(end_position) != ' '

    set_pieces(start_position, end_position)
    clear_pieces(start_position)
  end
end
