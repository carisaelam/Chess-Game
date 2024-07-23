# frozen_string_literal: true

require_relative 'piece_mover'
require_relative 'coordinate_converter'
require_relative 'board'
require_relative 'game_status'

class GameFlow
  attr_reader :board, :piece_mover, :coordinate_converter, :game_status
  attr_accessor :color

  def initialize(board, piece_mover, coordinate_converter, game_status)
    @board = board
    @piece_mover = piece_mover
    @coordinate_converter = coordinate_converter
    @game_status = game_status
    @color = :black
  end

  def toggle_color
    @color = @color == :black ? :white : :black
  end

  def start
    board.print_board
    loop do
      player_turn
      toggle_color
    end
  end

  private

  def player_turn
    enemy_color = color == :black ? :white : :black
    puts "#{color.capitalize}'s turn"

    if game_status.check?(color) == true
      p 'You are in CHECK. You must get out of check'
      p 'GAME OVER' if game_status.checkmate?(color) == true
    end
    print 'Select a piece: '
    start_point = check_start_input
    print 'Select an end point: '
    end_point = check_alg_input(gets.chomp)

    loop do
      move_piece(start_point, end_point)

      break unless game_status.check?(color)

      piece_mover.move_piece(end_point, start_point) # Revert the move
      puts 'That would put your king in check. Try again.'
      game_status.reset_check
      print 'Select a piece: '

      start_point = check_start_input
      print 'Select an end point: '
      end_point = check_alg_input(gets.chomp)
    end

    board.print_board
  end

  def check_start_input
    input = gets.chomp
    alg_cleared = check_alg_input(input)

    until check_piece_color(alg_cleared)
      puts 'Not your piece. Pick again'
      input = gets.chomp
      alg_cleared = check_alg_input(input)
    end

    alg_cleared
  end

  def check_piece_color(input)
    piece = board.piece_at(input)
    piece && piece.color == color
  end

  def check_alg_input(input)
    until ('a'..'h').include?(input[0]) && (1..8).include?(input[1].to_i)
      puts "Invalid input. Please enter a valid coordinate (e.g., 'e2'):"
      input = gets.chomp
    end

    coordinate_converter.convert_from_alg_notation(input)
  end

  def move_piece(start_position, end_position)
    unless piece_mover.validate_move(start_position, end_position)
      puts 'Not a valid move for that piece. Pick another end point'
      p "start: #{start_position} end: #{end_position}"
      new_end = check_alg_input(gets.chomp)
      p "new end: #{new_end}"
      move_piece(start_position, new_end)
    end

    piece_mover.move_piece(start_position, end_position)
  end
end

# # GameFlow Class Goals

# [ ] Manage Turn Sequence
#   [x] Alternate turns between players.
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
#   [x] Keep track of the current game state (e.g., active pieces, board configuration).
#   [ ] Manage game history (optional, for undo/redo functionality).

# [ ] Interface with Other Classes
#   [x] Coordinate with the `Board` class to update and query the board state.
#   [x] Utilize `Piece` classes to validate and execute piece-specific moves.

# [ ] Provide Game Status Information
#   [ ] Display current game status (e.g., which player’s turn it is, if a player is in check).
