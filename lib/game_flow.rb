# frozen_string_literal: true

require_relative 'piece_mover'
require_relative 'coordinate_converter'
require_relative 'board'

class GameFlow
  attr_reader :board, :piece_mover, :coordinate_converter

  def initialize(board, piece_mover, coordinate_converter)
    @board = board
    @piece_mover = piece_mover
    @coordinate_converter = coordinate_converter
  end

  def start
    board.print_board
    loop do
      p 'pick a start point'
      start_point = gets.chomp
      p 'pick an end point'
      end_point = gets.chomp
      move_piece(start_point, end_point)
      board.print_board
    end
  end

  private

  def move_piece(start_position, end_position)
    start_coordinate = coordinate_converter.convert_from_alg_notation(start_position)
    end_coordinate = coordinate_converter.convert_from_alg_notation(end_position)

    return nil unless start_coordinate && end_coordinate

    piece_mover.move_piece(start_coordinate, end_coordinate)
  end
end

# # GameFlow Class Goals

# [ ] Manage Turn Sequence
#   [ ] Alternate turns between players.
#   [ ] Keep track of which player's turn it is.

# [ ] Handle Move Execution
#   [ ] Validate the move according to the rules of chess.
#   [ ] Update the board with the new piece positions.
#   [ ] Handle special moves (e.g., castling, en passant).

# [ ] Validate Moves
#   [ ] Check if a move is legal based on piece type and current board state.
#   [ ] Ensure that moves do not put the player's king in check.

# [ ] Check Game Status
#   [ ] Determine if the game has ended (checkmate, stalemate).
#   [ ] Handle game-ending conditions and notify players.

# [ ] Handle Player Input
#   [ ] Interpret player commands and translate them into moves.
#   [ ] Provide feedback to players on invalid moves or game status.

# [ ] Maintain Game State
#   [ ] Keep track of the current game state (e.g., active pieces, board configuration).
#   [ ] Manage game history (optional, for undo/redo functionality).

# [ ] Interface with Other Classes
#   [ ] Coordinate with the `Board` class to update and query the board state.
#   [ ] Utilize `Piece` classes to validate and execute piece-specific moves.

# [ ] Provide Game Status Information
#   [ ] Display current game status (e.g., which player’s turn it is, if a player is in check).
