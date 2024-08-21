# frozen_string_literal: true

require_relative 'board'

# stores common attributes and methods for all pieces
class Piece
  attr_reader :color, :position, :board, :castle_available

  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
  end

  # provides a string equivalent that clarifies color, piece type, and position
  def to_s
    "#{color.capitalize} #{self.class} #{position}"
  end

  # passes responsibility of validating move to piece subclass
  def valid_move?(start_position, end_position)
    p "valid move running start: #{start_position} end: #{end_position}"
    # Forces subclasses to handle their own move validation
    raise NotImplementedError, 'Method should be called from subclass'
  end

  # returns true if the given position is on the board
  def in_bounds?(position)
    position.all? { |coord| coord.between?(0, 7) }
  end

  # updates position instance variable to new position
  def update_position(new_position)
    @position = new_position
  end

  # returns true if color at position is the same as the color variable
  def check_colors(position)
    piece = @board.piece_at(position)
    piece.color != color || piece.color == :empty
  end
end
