require_relative '../piece'

class Pawn < Piece
  def initialize(color, position)
    super(color, position)
  end

  def unicode_symbol
    if color == :white
      "\u2659"
    else
      "\u265F"
    end
  end
end
