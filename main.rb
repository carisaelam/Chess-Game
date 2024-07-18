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

knight = Knight.new(:white, [0, 4])
board.place_piece(knight, [0, 3])

board.print_board
board.starting_positions
board.print_board

pp board.board[6][0][1].unicode_symbol
p piece_mover.move_piece([6, 0], [5, 0])
board.print_board

p board.piece_at([5, 0])
p board.piece_at([6, 0])
