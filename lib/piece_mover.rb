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
    p 'move_piece runing from within piecemover'
    p "start position: #{start_position}"
    p "end position: #{end_position}"
    # ensures end_position is on the board
    return nil if check_in_bounds(end_position) == false

    p "we're in bounds.."
    # ensures end_position is not already taken
    return end_point(end_position) if end_point(end_position) != ' '

    p 'about to run set_pieces'
    set_pieces(start_position, end_position)
    clear_pieces(start_position)
  end

  # simply collects user input through gets.chomp
  def collect_input
    gets.chomp
  end

  def process_coordinate_input(string)
    [string[0], string[1]]
  end

  def convert_from_alg_notation
    input = process_coordinate_input(collect_input.downcase)
    [square_coordinates[input[1]], square_coordinates[input[0]]]
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
    p 'inside set_pieces'
    p "start #{start_position} end: #{end_position}"

    @board.board[end_position[0]][end_position[1]][1] = @board.board[start_position[0]][start_position[1]][1]
    p "after move start #{start_position} end: #{end_position}"
  end

  # clears piece from start_position
  def clear_pieces(start_position)
    p 'clear pieces running now'
    @board.board[start_position[0]][start_position[1]][1] = ' '
  end
end
