require_relative '../piece'
require_relative '../board'


class Queen < Piece


  def unicode_symbol
    if color == :white
      "\u2655"
    else
      "\u265B"
    end
  end
end
