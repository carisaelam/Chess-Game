# frozen_string_literal: true

class PieceMover
  def initialize(board)
    @board = board
  end

  SQUARE_COORDINATES = {
    'a' => 0,
    'b' => 1,
    'c' => 2,
    'd' => 3,
    'e' => 4,
    'f' => 5,
    'g' => 6,
    'h' => 7,

    '0' => 8,
    '1' => 7,
    '2' => 6,
    '3' => 5,
    '4' => 4,
    '5' => 3,
    '6' => 2,
    '7' => 1,
    '8' => 0

  }.freeze

  # copies start_position piece onto the end_position piece
  def move_piece(start_position, end_position)
    return nil if check_in_bounds(end_position) == false

    return nil if end_point(end_position) != ' '

    set_pieces(start_position, end_position)
    clear_pieces(start_position)
  end

  def collect_input
    gets.chomp
  end

  def process_input(string)
    letter = string[0]
    number = string[1]
    [letter, number]
  end

  def convert_from_alg_notation
    input = process_input(collect_input)
    p converted_input = [square_coordinates[input[1]], square_coordinates[input[0]]]
  end

  private

  def square_coordinates
    SQUARE_COORDINATES
  end

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

  # copies the piece from the start position to the end position
  def set_pieces(start_position, end_position)
    @board.board[end_position[0]][end_position[1]][1] = @board.board[start_position[0]][start_position[1]][1]
  end

  # clears piece from start_position
  def clear_pieces(start_position)
    @board.board[start_position[0]][start_position[1]][1] = ' '
  end
end
