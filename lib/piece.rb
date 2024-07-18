require_relative 'board'

class Piece
  attr_accessor :color, :position

  def initialize(color, position)
    @color = color
    @position = position
  end

  def to_s
    "#{color}_#{self.class.name.downcase}"
  end

  def valid_move?(start_position, end_position)
    raise NotImplementedError, 'Method should be called from subclass'
  end
end
