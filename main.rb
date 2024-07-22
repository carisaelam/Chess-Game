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

board = Board.new
piece_mover = PieceMover.new(board)
coordinate_converter = CoordinateConverter.new

game = GameFlow.new(board, piece_mover, coordinate_converter)
game.start
