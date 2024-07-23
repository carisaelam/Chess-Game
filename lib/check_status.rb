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
    p 'Checking for checkmate...'
    return false unless check?(color)

    all_friendly_pieces = friendly_pieces(color)

    checkmate = all_friendly_pieces.all? do |piece|
      piece.all_valid_moves(piece.position).none? do |move|
        can_escape_check?(piece, move)
      end
    end

    if checkmate == true
      p 'CHECKMATE'
    else
      nil
    end
  end

  def can_escape_check?(piece, move_position)
    simulate_move(piece, move_position)
    !check?(piece.color)
  end

  def simulate_move(piece, move_position)
    original_position = piece.position
    piece_mover.move_piece(original_position, move_position)
    in_check = check?(piece.color)
    piece_mover.move_piece(move_position, original_position) # Revert move
    in_check
  end

  def friendly_pieces(color)
    all_positions.map do |position|
      board.piece_at(position)
    end.select { |piece| piece.color == color }.reject { |piece| piece.instance_of?(EmptyPiece) }
  end

  # Determines if your king is in check
  def check?(color)
    enemy_color = determine_enemy_color(color)
    enemy_moves = collect_enemy_moves(enemy_color)

    @check = enemy_moves.any? do |position, moves|
      moves.any? do |move_position|
        check_if_in_check?(color, move_position)
      end
    end

    p "Check on #{color}" if @check
    @check
  end

  def determine_enemy_color(color)
    color == :black ? :white : :black
  end

  def collect_enemy_moves(enemy_color)
    all_valid_moves_on_board(enemy_color)
  end

  def check_if_in_check?(color, move_position)
    potential_end_point = board.piece_at(move_position)
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

      all_moves[piece.position] = piece.all_valid_moves(piece.position)
    end
    all_moves.reject { |position, moves| moves.empty? }
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
