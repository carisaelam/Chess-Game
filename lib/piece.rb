require_relative 'board'

class Piece
  attr_reader :color, :position, :board

  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
  end

  def to_s
    "#{color} #{self.class.name} at #{position}"
  end

  def valid_move?(start_position, end_position)
    raise NotImplementedError, 'Method should be called from subclass'
  end
end
