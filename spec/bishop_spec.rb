require_relative '../lib/pieces/bishop'
require_relative '../lib/board'

RSpec.describe Bishop do
  let(:board) { instance_double('Board') }
  let(:white_bishop) { Bishop.new(:white, [0, 2], board) }
  let(:black_bishop) { Bishop.new(:black, [7, 2], board) }

  describe '#unicode_symbol' do
    it 'returns the correct symbol for a white bishop' do
      expect(white_bishop.unicode_symbol).to eq("\u2657")
    end

    it 'returns the correct symbol for a black bishop' do
      expect(black_bishop.unicode_symbol).to eq("\u265D")
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the bishop piece' do
      expect(white_bishop.to_s).to eq('White Bishop [0, 2] - INSTANCE')
    end
  end

  describe '#valid_move?' do
    before do
      allow(board).to receive(:piece_at).and_return(instance_double('Piece', color: :empty))
    end

    context 'when the move is valid' do
      it 'returns true for a valid diagonal move' do
        expect(white_bishop.valid_move?([0, 2], [3, 5])).to be true
      end

      it 'returns true for another valid diagonal move' do
        expect(white_bishop.valid_move?([0, 2], [4, 6])).to be true
      end
    end

    context 'when the move is invalid' do
      it 'returns false for an invalid move' do
        allow(board).to receive(:piece_at).with([2, 3]).and_return(instance_double('Piece', color: :empty))
        expect(white_bishop.valid_move?([0, 2], [2, 3])).to be false
      end

      it 'returns false for a horizontal move' do
        expect(white_bishop.valid_move?([0, 2], [0, 5])).to be false
      end

      it 'returns false for a vertical move' do
        expect(white_bishop.valid_move?([0, 2], [3, 2])).to be false
      end
    end
  end
end
