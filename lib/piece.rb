# frozen_string_literal: true

require_relative 'board'

class Piece
  attr_reader :color, :position, :board

  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
  end

  def to_s
    "#{color.capitalize} #{self.class} #{position} - INSTANCE"
  end

  def valid_move?(start_position, end_position)
    raise NotImplementedError, 'Method should be called from subclass'
  end

  def in_bounds?(position)
    position.all? { |coord| coord.between?(0, 7) }
  end

  def update_position(new_position)
    @position = new_position
  end

  def check_colors(position)
    piece = @board.piece_at(position)
    piece.color != color || piece.color == :empty
  end
end
