# frozen_string_literal: true

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
require_relative 'lib/pieces/empty_piece'
require_relative 'lib/game_flow'
require_relative 'lib/check_status'
require_relative 'lib/serialize'
require 'yaml'

board = Board.new
piece_mover = PieceMover.new(board)
coordinate_converter = CoordinateConverter.new
check_status = CheckStatus.new(board)

game = GameFlow.new(board, piece_mover, coordinate_converter, check_status)
game.start

# board.place_piece(EmptyPiece.new, [1, 0])
# board.place_piece(EmptyPiece.new, [1, 1])
# board.place_piece(EmptyPiece.new, [1, 2])
# board.place_piece(EmptyPiece.new, [1, 3])
# board.place_piece(EmptyPiece.new, [1, 4])
# board.place_piece(EmptyPiece.new, [1, 5])
# board.place_piece(EmptyPiece.new, [1, 6])
# board.place_piece(EmptyPiece.new, [1, 7])

# # board.place_piece(EmptyPiece.new, [6, 0])
# board.place_piece(EmptyPiece.new, [6, 1])
# board.place_piece(EmptyPiece.new, [6, 2])
# board.place_piece(EmptyPiece.new, [6, 3])
# board.place_piece(EmptyPiece.new, [6, 4])
# board.place_piece(EmptyPiece.new, [6, 5])
# board.place_piece(EmptyPiece.new, [6, 6])
# board.place_piece(EmptyPiece.new, [6, 7])

# board.place_piece(EmptyPiece.new, [7, 0])
# board.place_piece(EmptyPiece.new, [7, 1])
# board.place_piece(EmptyPiece.new, [7, 2])
# board.place_piece(EmptyPiece.new, [7, 3])
# board.place_piece(EmptyPiece.new, [7, 4])
# board.place_piece(EmptyPiece.new, [7, 5])
# board.place_piece(EmptyPiece.new, [7, 6])
# board.place_piece(EmptyPiece.new, [7, 7])

# # board.place_piece(EmptyPiece.new, [0, 0])
# board.place_piece(EmptyPiece.new, [0, 1])
# board.place_piece(EmptyPiece.new, [0, 2])
# board.place_piece(EmptyPiece.new, [0, 3])
# # board.place_piece(EmptyPiece.new, [0, 4])
# board.place_piece(EmptyPiece.new, [0, 5])
# board.place_piece(EmptyPiece.new, [0, 6])
# board.place_piece(EmptyPiece.new, [0, 7])

# piece_mover.move_piece([6, 0], [6, 1])
# board.print_board

# check_status.check?(:black)
# check_status.checkmate?(:black)
