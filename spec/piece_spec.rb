require_relative '../lib/piece'
require_relative '../lib/board'

RSpec.describe Piece do
  let(:board) { instance_double(Board) }
  let(:piece) { Piece.new(:white, [0, 0], board) }

  describe '#initialize' do
    it 'assigns color, position, and board' do
      expect(piece.color).to eq(:white)
      expect(piece.position).to eq([0, 0])
      expect(piece.board).to eq(board)
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the piece' do
      expect(piece.to_s).to eq('White Piece [0, 0] - INSTANCE')
    end
  end

  describe '#valid_move?' do
    it 'raises NotImplementedError when called on the base class' do
      expect do
        piece.valid_move?([0, 0], [1, 1])
      end.to raise_error(NotImplementedError, 'Method should be called from subclass')
    end
  end
end
