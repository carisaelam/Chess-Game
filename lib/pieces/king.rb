require_relative '../piece'

class King < Piece
  def initialize(color, position)
    super(color, position)
  end

  def unicode_symbol
    if color == :white
      "\u2654"
    else
      "\u265A"
    end
  end
end
