require_relative 'lib/board'
require_relative 'lib/coordinate_converter'
require_relative 'lib/piece'
require_relative 'lib/piece_mover'
require_relative 'lib/pieces/knight'
require_relative 'lib/pieces/bishop'
require_relative 'lib/pieces/rook'
require_relative 'lib/pieces/pawn'
require_relative 'lib/pieces/king'
require_relative 'lib/pieces/queen'

board = Board.new
coordinate_converter = CoordinateConverter.new
piece_mover = PieceMover.new(board)

board.print_board
board.starting_positions
board.print_board

piece_mover.move_piece([7, 1], [5, 0])
board.print_board

piece_mover.move_piece([5, 0], [3, 1])
board.print_board

p 'out of bounds move coming up'
piece_mover.move_piece([3, 1], [9, 1])
board.print_board

p 'invalid move for type coming up'
piece_mover.move_piece([3, 1], [3, 2])
board.print_board
