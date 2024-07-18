require_relative '../piece'

class Bishop < Piece
  def initialize(color, position)
    super(color, position)
  end

  def unicode_symbol
    if color == :white
      "\u2657"
    else
      "\u265D"
    end
  end
end
