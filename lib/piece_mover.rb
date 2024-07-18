# frozen_string_literal: true

class PieceMover
  attr_reader :board

  def initialize(board)
    @board = board
  end

  # copies start_position piece onto the end_position piece
  def move_piece(start_position, end_position)
    return false unless validate_move(start_position, end_position)

    set_pieces(start_position, end_position)
    clear_pieces(start_position)
  end

  # clears piece from start_position
  # # MAKE PRIVATE AGAIN
  def clear_pieces(start_position)
    p 'clear pieces running now'
    @board.board[start_position[0]][start_position[1]][1] = ' '
  end

  private

  def validate_move(start_position, end_position)
    check_in_bounds(end_position) &&
      valid_move_for_type(start_position, end_position)

    # ensures end_position is not already taken
  end

  def valid_move_for_type(start_position, end_position)
    start_piece = start_point(start_position) # contents of start square
    puts "start piece: #{start_piece}"
    return true if start_piece.valid_move?(start_position, end_position)

    p 'NOT A VALID MOVE FOR THAT PIECE'
    false
  end

  # check if position is on the board
  def check_in_bounds(position)
    return true if position[0].between?(0, 7) && position[1].between?(0, 7)

    p 'OUT OF BOUNDS'
    false
  end

  # return start_position from board
  def start_point(start_position)
    @board.board[start_position[0]][start_position[1]][1]
  end

  # return end_position from board
  def end_point(end_position)
    @board.board[end_position[0]][end_position[1]][1]
  end

  # copies the piece from the start position to the end position
  def set_pieces(start_position, end_position)
    p 'inside set_pieces'
    p "start #{start_position} end: #{end_position}"
    p "before move #{@board.board[end_position[0]][end_position[1]][1]}"
    @board.board[end_position[0]][end_position[1]][1] = @board.board[start_position[0]][start_position[1]][1]

    p "after move  #{@board.board[end_position[0]][end_position[1]][1]}"
  end
end
