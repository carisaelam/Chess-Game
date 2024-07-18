require_relative '../piece'

class Queen < Piece
  def initialize(color, position)
    super(color, position)
  end

  def unicode_symbol
    if color == :white
      "\u2655"
    else
      "\u265B"
    end
  end
end
