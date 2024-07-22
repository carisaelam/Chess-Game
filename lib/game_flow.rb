# frozen_string_literal: true

require_relative 'piece_mover'
require_relative 'coordinate_converter'
require_relative 'board'
require_relative 'game_status'

class GameFlow
  attr_reader :board, :piece_mover, :coordinate_converter, :game_status

  def initialize(board, piece_mover, coordinate_converter, game_status)
    @board = board
    @piece_mover = piece_mover
    @coordinate_converter = coordinate_converter
    @game_status = game_status
  end

  def player_turn
    p 'Player ____'
    print 'pick a start point '
    start_point = gets.chomp
    print 'pick an end point '
    end_point = gets.chomp
    move_piece(start_point, end_point)
    board.print_board
  end

  def start
    board.print_board
    loop do
      player_turn
      game_status.check?(:white)
      # switch-player
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
#   [x] Validate the move according to the rules of chess.
#   [x] Update the board with the new piece positions.
#   [ ] Handle special moves (e.g., castling, en passant).

# [ ] Validate Moves
#   [x] Check if a move is legal based on piece type and current board state.
#   [ ] Ensure that moves do not put the player's king in check.

# [ ] Check Game Status
#   [ ] Determine if the game has ended (checkmate, stalemate).
#   [ ] Handle game-ending conditions and notify players.

# [x] Handle Player Input
#   [x] Interpret player commands and translate them into moves.
#   [x] Provide feedback to players on invalid moves or game status.

# [ ] Maintain Game State
#   [ ] Keep track of the current game state (e.g., active pieces, board configuration).
#   [ ] Manage game history (optional, for undo/redo functionality).

# [ ] Interface with Other Classes
#   [x] Coordinate with the `Board` class to update and query the board state.
#   [x] Utilize `Piece` classes to validate and execute piece-specific moves.

# [ ] Provide Game Status Information
#   [ ] Display current game status (e.g., which player’s turn it is, if a player is in check).
