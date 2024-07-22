require_relative 'board'
require_relative 'piece'

class GameStatus
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def check?
    knight = board.piece_at([2, 2])
    puts knight
    p knight.all_valid_moves(knight.position)
    # then check to see if other king is in any of the positions
  end
end
