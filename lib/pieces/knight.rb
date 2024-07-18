require_relative '../piece'

class Knight < Piece
  def initialize(color, position)
    super(color, position)
  end

  def unicode_symbol
    if color == :white
      "\u2658"
    else
      "\u265E"
    end
  end
end
