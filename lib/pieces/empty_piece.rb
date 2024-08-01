# frozen_string_literal: true

require_relative '../piece'

# specifics for empty pieces
class EmptyPiece < Piece
  def initialize
    super(:empty, [0, 0], nil)
  end

  def unicode_symbol
    return unless color == :empty

    ' '
  end
end
