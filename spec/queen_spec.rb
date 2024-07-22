require_relative '../lib/pieces/queen'
require_relative '../lib/board'

RSpec.describe Queen do
  let(:board) { instance_double('Board') }
  let(:white_queen) { Queen.new(:white, [0, 3], board) }
  let(:black_queen) { Queen.new(:black, [7, 3], board) }

  describe '#unicode_symbol' do
    it 'returns the correct symbol for a white queen' do
      expect(white_queen.unicode_symbol).to eq("\u2655")
    end

    it 'returns the correct symbol for a black queen' do
      expect(black_queen.unicode_symbol).to eq("\u265B")
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the queen piece' do
      expect(white_queen.to_s).to eq('White Queen [0, 3] - INSTANCE')
    end
  end

  describe '#valid_move?' do
    before do
      allow(board).to receive(:piece_at).and_return(instance_double('Piece', color: :empty))
    end

    context 'when the move is valid' do
      it 'returns true for a valid diagonal move' do
        expect(white_queen.valid_move?([0, 3], [3, 6])).to be true
      end

      it 'returns true for a valid vertical move' do
        expect(white_queen.valid_move?([0, 3], [4, 3])).to be true
      end

      it 'returns true for a valid horizontal move' do
        expect(white_queen.valid_move?([0, 3], [0, 7])).to be true
      end
    end

    context 'when the move is invalid' do
      it 'returns false for an invalid move' do
        expect(white_queen.valid_move?([0, 3], [2, 6])).to be false
      end
    end
  end
end
