require_relative '../piece'

class Rook < Piece
  def initialize(color, position)
    super(color, position)
  end

  def unicode_symbol
    if color == :white
      "\u2656"
    else
      "\u265C"
    end
  end
end
