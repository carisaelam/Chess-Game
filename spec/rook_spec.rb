require 'rspec'
require_relative '../lib/pieces/rook'
require_relative '../lib/board'

RSpec.describe Rook do
  let(:board) { instance_double('Board') }
  let(:white_rook) { Rook.new(:white, [0, 0], board) }
  let(:black_rook) { Rook.new(:black, [7, 7], board) }

  describe '#unicode_symbol' do
    it 'returns the correct symbol for a white rook' do
      expect(white_rook.unicode_symbol).to eq("\u2656")
    end

    it 'returns the correct symbol for a black rook' do
      expect(black_rook.unicode_symbol).to eq("\u265C")
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the rook piece' do
      expect(white_rook.to_s).to eq('White Rook [0, 0] - INSTANCE')
    end
  end

  describe '#valid_move?' do
    before do
      allow(board).to receive(:piece_at).and_return(instance_double('Piece', color: :empty))
    end

    context 'when the move is valid' do
      it 'returns true for a valid horizontal move to the right' do
        expect(white_rook.valid_move?([0, 0], [0, 5])).to be true
      end

      it 'returns true for a valid horizontal move to the left' do
        expect(black_rook.valid_move?([7, 7], [7, 2])).to be true
      end

      it 'returns true for a valid vertical move up' do
        expect(white_rook.valid_move?([0, 0], [5, 0])).to be true
      end

      it 'returns true for a valid vertical move down' do
        expect(black_rook.valid_move?([7, 7], [2, 7])).to be true
      end
    end

    context 'when the move is invalid' do
      it 'returns false for a diagonal move' do
        expect(white_rook.valid_move?([0, 0], [3, 3])).to be false
      end

      it 'returns false for an L-shaped move' do
        expect(white_rook.valid_move?([0, 0], [2, 1])).to be false
      end

      it 'returns false for a move out of bounds' do
        expect(white_rook.valid_move?([0, 0], [0, 8])).to be false
      end
    end
  end

  describe '#generate_moves' do
    it 'generates moves in a straight line until the edge of the board or another piece' do
      allow(board).to receive(:piece_at).and_return(instance_double('Piece', color: :empty))

      row = 0
      col = 0
      expect(white_rook.send(:generate_moves, row, col, 0,
                             1)).to include([0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7])
    end

    it 'stops generating moves when it encounters a piece of the same color' do
      allow(board).to receive(:piece_at).with([0, 1]).and_return(instance_double('Piece', color: :white))
      expect(white_rook.send(:generate_moves, 0, 0, 0, 1)).to be_empty
    end

    it 'includes the capture move and stops when it encounters an enemy piece' do
      allow(board).to receive(:piece_at).with([0, 1]).and_return(instance_double('Piece', color: :black))
      expect(white_rook.send(:generate_moves, 0, 0, 0, 1)).to eq([[0, 1]])
    end
  end

  describe '#in_bounds?' do
    it 'returns true for a position within the board bounds' do
      expect(white_rook.send(:in_bounds?, [0, 0])).to be true
    end

    it 'returns false for a position outside the board bounds' do
      expect(white_rook.send(:in_bounds?, [0, 8])).to be false
    end
  end
end
