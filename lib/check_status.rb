# frozen_string_literal: true

require_relative 'board'
require_relative 'piece'
require_relative 'piece_mover'

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
    # p 'Checking for checkmate...'
    return false unless check?(color)

    all_friendly_pieces = friendly_pieces(color)

    checkmate = all_friendly_pieces.all? do |piece|
      piece.all_valid_moves(piece.position).none? do |move|
        # p "piece: #{piece}"
        # p "move: #{move}"
        # p "escape? #{can_escape_check?(piece, move)}"
        can_escape_check?(piece, move)
      end
    end

    p "CHECKMATE! #{determine_enemy_color(color).capitalize} wins!" if checkmate == true
    checkmate
  end

  def can_escape_check?(piece, move_position)
    # p 'can escape check running'
    !simulate_move(piece, move_position)
  end

  def simulate_move(piece, move_position)
    # p "simulating move #{piece.position} to #{move_position}"
    original_position = piece.position
    # if there is a piece in move_position, get it's info
    captured_piece = board.piece_at(move_position)
    # p "captured_piece= #{captured_piece}"
    piece_mover.move_piece(original_position, move_position)
    in_check = check?(piece.color)
    piece_mover.move_piece(move_position, original_position) # Revert move
    board.place_piece(captured_piece, move_position) # puts back captured piece
    # p "check that captured piece is back in place: #{board.piece_at(move_position)}"
    # p "simulated move #{piece.position} to #{move_position} resulted in check? #{in_check}"
    in_check
  end

  def friendly_pieces(color)
    all_positions.map do |position|
      board.piece_at(position)
    end.select { |piece| piece.color == color }.reject { |piece| piece.instance_of?(EmptyPiece) }
  end

  # Determines if your king is in check
  def check?(color)
    # p "starting check. status of check is #{@check}"
    enemy_color = determine_enemy_color(color)
    enemy_moves = collect_enemy_moves(enemy_color)

    @check = enemy_moves.any? do |_, moves|
      moves.any? do |move_position|
        check_if_in_check?(color, move_position)
      end
    end

    # p "now status of check is #{@check}"

    # p "Check on #{color}" if @check == true
    @check
  end

  def determine_enemy_color(color)
    color == :black ? :white : :black
  end

  def collect_enemy_moves(enemy_color)
    all_valid_moves_on_board(enemy_color)
  end

  # returns true if enemy move_position
  def check_if_in_check?(color, move_position)
    potential_end_point = board.piece_at(move_position)
    return false if potential_end_point.instance_of?(EmptyPiece)

    # p "running check_if_in_check? for #{move_position}  potential_end_point: #{potential_end_point}"

    potential_end_point.color == color && potential_end_point.instance_of?(King)
  end

  def reset_check
    @check = false
  end

  private

  # returns hash of valid moves per position [x, y] => [[x, y], [x, y]]
  def all_valid_moves_on_board(color)
    all_moves = {}
    all_positions.each do |square|
      piece = board.piece_at(square)
      next if piece.instance_of?(EmptyPiece) || piece.color != color
      next if piece.all_valid_moves(piece.position).empty?

      # puts "moves for #{piece} include #{piece.all_valid_moves(piece.position)}"
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
