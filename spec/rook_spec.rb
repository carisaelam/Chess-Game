require 'spec_helper'

describe Rook do
  let(:board) { Board.new }
  let(:rook) { Rook.new(:white, [0, 0], board) }

  describe '#unicode_symbol' do
    it 'returns the correct unicode symbol for a white rook' do
      expect(rook.unicode_symbol).to eq("\u2656")
    end

    it 'returns the correct unicode symbol for a black rook' do
      black_rook = Rook.new(:black, [0, 0], board)
      expect(black_rook.unicode_symbol).to eq("\u265C")
    end
  end

  describe '#valid_move?' do
    context 'when the move is valid' do
      it 'returns true for a valid move' do
        allow(board).to receive(:piece_at).and_return(EmptyPiece.new)
        expect(rook.valid_move?([0, 0], [0, 5])).to be true
      end
    end

    context 'when the move is invalid' do
      it 'returns false for a move out of bounds' do
        expect(rook.valid_move?([0, 0], [0, 8])).to be false
      end

      it 'returns false for a move blocked by a piece of the same color' do
        allow(board).to receive(:piece_at).and_return(Rook.new(:white, [0, 1], board))
        expect(rook.valid_move?([0, 0], [0, 5])).to be false
      end
    end
  end

  describe '#all_valid_moves' do
    it 'returns all valid moves from the current position' do
      allow(board).to receive(:piece_at).and_return(EmptyPiece.new)
      expect(rook.all_valid_moves([0, 0])).to include([0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7])
    end
  end
end
