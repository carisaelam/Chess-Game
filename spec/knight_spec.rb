require 'rspec'
require_relative '../lib/pieces/knight'
require_relative '../lib/board'

RSpec.describe Knight do
  let(:board) { instance_double('Board') }
  let(:white_knight) { Knight.new(:white, [0, 1], board) }
  let(:black_knight) { Knight.new(:black, [7, 1], board) }

  describe '#unicode_symbol' do
    it 'returns the correct symbol for a white knight' do
      expect(white_knight.unicode_symbol).to eq("\u2658")
    end

    it 'returns the correct symbol for a black knight' do
      expect(black_knight.unicode_symbol).to eq("\u265E")
    end
  end

  describe '#valid_move?' do
    context 'when the move is valid' do
      it 'returns true for a valid L-shaped move' do
        expect(white_knight.valid_move?([0, 1], [2, 2])).to be true
      end

      it 'returns true for another valid L-shaped move' do
        expect(white_knight.valid_move?([0, 1], [1, 3])).to be true
      end
    end

    context 'when the move is invalid' do
      it 'returns false for an invalid move' do
        expect(white_knight.valid_move?([0, 1], [3, 3])).to be false
      end

      it 'returns false for a straight move' do
        expect(white_knight.valid_move?([0, 1], [0, 3])).to be false
      end

      it 'returns false for a diagonal move' do
        expect(white_knight.valid_move?([0, 1], [2, 3])).to be false
      end
    end
  end
end
