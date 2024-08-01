# frozen_string_literal: true

require_relative 'board'
require_relative 'piece'
require_relative 'piece_mover'

# determines if king is in check or checkmate
class CheckStatus
  attr_reader :board, :piece_mover
  attr_accessor :check

  def initialize(board)
    @board = board
    @check = false
    @piece_mover = PieceMover.new(board)
  end

  # determines if your king is in checkmate
  def checkmate?(color)
    return false unless check?(color)

    all_friendly_pieces = friendly_pieces(color)

    checkmate = all_friendly_pieces.all? do |piece|
      piece.all_valid_moves(piece.position).none? do |move|
        can_escape_check?(piece, move)
      end
    end

    p "CHECKMATE! #{determine_enemy_color(color).capitalize} wins!" if checkmate == true
    checkmate
  end

  # simulates a move to determine if it would put king in check
  def simulate_move(piece, move_position)
    original_position = piece.position
    captured_piece = board.piece_at(move_position)
    piece_mover.move_piece(original_position, move_position)
    in_check = check?(piece.color)
    piece_mover.move_piece(move_position, original_position) # Revert move
    board.place_piece(captured_piece, move_position) # puts back captured piece

    in_check
  end

  # Determines if your king is in check
  def check?(color)
    enemy_color = determine_enemy_color(color)
    enemy_moves = all_valid_moves_on_board(enemy_color)

    @check = enemy_moves.any? do |_, moves|
      moves.any? do |move_position|
        check_if_in_check?(color, move_position)
      end
    end

    @check
  end

  # returns true if enemy move_position
  def check_if_in_check?(color, move_position)
    potential_end_point = board.piece_at(move_position)
    return false if potential_end_point.instance_of?(EmptyPiece)

    potential_end_point.color == color && potential_end_point.instance_of?(King)
  end

  # sets check to false
  def reset_check
    @check = false
  end

  private

  # returns true if a valid move exists that would remove check status
  def can_escape_check?(piece, move_position)
    !simulate_move(piece, move_position)
  end

  # simply returns black if white is given and vice versa
  def determine_enemy_color(color)
    color == :black ? :white : :black
  end

  # returns array of all friendly pieces on the board
  def friendly_pieces(color)
    all_positions.each_with_object([]) do |position, pieces|
      piece = board.piece_at(position)
      pieces << piece if piece.color == color && !piece.instance_of?(EmptyPiece)
    end
  end

  # returns hash of valid moves per position [x, y] => [[x, y], [x, y]]
  def all_valid_moves_on_board(color)
    all_moves = {}
    all_positions.each do |square|
      piece = board.piece_at(square)
      next if piece.instance_of?(EmptyPiece) || piece.color != color
      next if piece.all_valid_moves(piece.position).empty?

      all_moves[piece.position] = piece.all_valid_moves(piece.position)
    end
    all_moves.reject { |_position, moves| moves.empty? }
  end

  # generate list of all positions on board [x, y]
  def all_positions
    positions = []
    (0..7).each do |row|
      (0..7).each do |col|
        positions << [row, col]
      end
    end
    positions
  end
end
