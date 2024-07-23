require_relative 'board'
require_relative 'piece'
require_relative 'piece_mover'

class GameStatus
  attr_reader :board, :piece_mover
  attr_accessor :check

  def initialize(board)
    @board = board
    @check = false
  end

  # determines if your king is in checkmate
  def checkmate?(color)
    p 'running checkmate'
  end

  # determines if your king is in check
  def check?(color)
    enemy_color = color == :black ? :white : :black
    all_moves = all_valid_moves_on_board(enemy_color)
    all_moves.each do |move|
      unless board.piece_at(move).color != enemy_color && board.piece_at(move).color != :empty && board.piece_at(move).instance_of?(King)
        next
      end

      @check = true
    end
    p @check
    @check == true
  end

  def reset_check
    @check = false
  end

  private

  # lists all valid moves for a color
  def all_valid_moves_on_board(color)
    all_moves = []
    all_positions.each do |square|
      piece = board.piece_at(square)
      next if piece.instance_of?(EmptyPiece)
      next if piece.color != color

      all_moves << piece.all_valid_moves(piece.position)
    end
    all_moves.flatten(1)
  end

  # lists all pieces and their valid moves
  def all_piece_moves_on_board(color)
    all_piece_moves = []
    all_positions.each do |square|
      piece = board.piece_at(square)
      next if piece.instance_of?(EmptyPiece)
      next if piece.color != color

      all_piece_moves.push({ piece.position => piece.all_valid_moves(piece.position) })
    end
    all_piece_moves
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
