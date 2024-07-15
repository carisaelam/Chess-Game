require_relative '../lib/piece_mover'
require_relative '../lib/board'

RSpec.describe PieceMover do
  describe '#move_piece' do
    context 'moving pawn from starting position' do
      subject(:piece_mover) { described_class.new(board) }
      let(:board) { Board.new }

      before do
        board.starting_positions
        p 'Before move:'
        board.draw_board
      end

      it 'moves the white pawn up one' do
        piece_mover.move_piece([6, 0], [5, 0])
        expect(board.board[5][0][1]).to eq("\u2659") # Ensure you use the correct Unicode for pawn
        p 'After move:'
        board.draw_board
      end

      it 'clears the white pawn from the starting position' do
        piece_mover.move_piece([6, 0], [5, 0]) # Pass Board instance to move_piece
        expect(board.board[6][0][1]).to eq(' ')
        p 'After move:'
        board.draw_board
      end
    end

    context 'when a piece exists in the end position' do
      subject(:piece_mover) { described_class.new(board) }
      let(:board) { Board.new }

      before do
        board.starting_positions
        p 'Before move:'
        board.print_board
      end

      # eventually will need to send this piece to verify
      it 'returns piece occupying attempted end position' do
        end_point_current = board.board[6][0][1]
        end_point_full = board.board[6][0]
        p "endpointcurrent: #{end_point_current}"
        p "endpointfull: #{end_point_full}"
        result = piece_mover.move_piece([7, 0], [6, 0])
        expect(result).to eq(end_point_current)
        p 'After move:'
        board.print_board
      end
    end

    context 'when end position is outside the board' do
      subject(:out_of_bounds) { described_class.new(board) }
      let(:board) { Board.new }

      before do
        board.starting_positions
        p 'Before move:'
        board.print_board
      end

      it 'returns nil' do
        result = out_of_bounds.move_piece([7, 0], [8, 0])
        expect(result).to eq(nil)
        p 'After move:'
        board.print_board
      end
    end
  end
end
