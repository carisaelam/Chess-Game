require_relative '../piece'
require_relative '../board'


class Bishop < Piece
  def unicode_symbol
    if color == :white
      "\u2657"
    else
      "\u265D"
    end
  end
end
