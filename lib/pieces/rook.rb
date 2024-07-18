require_relative '../piece'

class Rook < Piece
  def unicode_symbol
    if color == :white
      "\u2656"
    else
      "\u265C"
    end
  end

  def valid_move?(start_position, end_position)
    row = start_position[0]
    col = start_position[1]

    down_moves = [
      [row, col + 1],
      [row, col + 2],
      [row, col + 3],
      [row, col + 4],
      [row, col + 5],
      [row, col + 6],
      [row, col + 7]
    ]

    up_moves = [
      [row, col - 1],
      [row, col - 2],
      [row, col - 3],
      [row, col - 4],
      [row, col - 5],
      [row, col - 6],
      [row, col - 7]
    ]

    right_moves = [
      [row + 1, col],
      [row + 2, col],
      [row + 3, col],
      [row + 4, col],
      [row + 5, col],
      [row + 6, col],
      [row + 7, col]
    ]
    left_moves = [
      [row - 1, col],
      [row - 2, col],
      [row - 3, col],
      [row - 4, col],
      [row - 5, col],
      [row - 6, col],
      [row - 7, col]
    ]

    def in_bounds(position)
      position[0].between?(0, 7) && position[1].between?(0, 7)
    end

    moves = []
    down_moves.each do |move|
      p "my color #{color}"
      p move
      p in_bounds(move)

      moves << move
    end

    up_moves.each do |move|
      p move
      p in_bounds(move)
      moves << move
    end

    right_moves.each do |move|
      p move
      p in_bounds(move)
      moves << move
    end

    left_moves.each do |move|
      p move
      p in_bounds(move)
      moves << move
    end

    p "valid moves include: #{moves}"

    filtered_moves = filter_possible_moves(moves)
    filtered_moves.include?(end_position)
  end

  # filter out out of bounds moves
  def filter_possible_moves(moves)
    legal_moves = []

    moves.each do |move|
      next unless move[0].between?(0, 7) && move[1].between?(0, 7)

      legal_moves.push(move)
    end

    legal_moves
  end
end
