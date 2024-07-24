require 'rspec'
require_relative '../lib/board'
require_relative '../lib/piece'
require_relative '../lib/check_status'

RSpec.describe CheckStatus do
  let(:board) { instance_double(Board) }
  let(:check_status) { described_class.new(board) }

  describe '#initialize' do
    it 'initializes with a board and sets check to false' do
      expect(check_status.board).to eq(board)
      expect(check_status.check).to be false
    end
  end

  describe '#check?' do
    let(:king) { double('King', color: :black, instance_of?: true) }
    let(:other_piece) { double('Piece', color: :white, instance_of?: false) }

    before do
      allow(check_status).to receive(:all_valid_moves_on_board).and_return({ [0, 0] => [[1, 1]], [1, 1] => [[2, 2]] })
      allow(board).to receive(:piece_at).with([1, 1]).and_return(other_piece)
      allow(board).to receive(:piece_at).with([2, 2]).and_return(king)
    end

    it 'sets check to true if the king is in check' do
      allow(check_status).to receive(:check_if_in_check?).and_return(true)

      check_status.check?(:black)
      expect(check_status.check).to be true
    end

    it 'does not set check to true if the king is not in check' do
      allow(board).to receive(:piece_at).with([2, 2]).and_return(other_piece)
      check_status.check?(:white)
      expect(check_status.check).to be false
    end
  end

  describe '#all_valid_moves_on_board' do
    let(:piece) { double('Piece', color: :white, position: [0, 0]) }
    let(:empty_piece) { double('EmptyPiece', instance_of?: true) }

    before do
      allow(piece).to receive(:all_valid_moves).with([0, 0]).and_return([[2, 2]])
      allow(check_status).to receive(:all_positions).and_return([[0, 0], [1, 1]])
      allow(board).to receive(:piece_at).with([0, 0]).and_return(piece)
      allow(board).to receive(:piece_at).with([1, 1]).and_return(empty_piece)
    end

    it 'returns all valid moves for the given color' do
      result = check_status.send(:all_valid_moves_on_board, :white)
      expect(result).to eq({ [0, 0] => [[2, 2]] })
    end
  end

  describe '#all_positions' do
    it 'returns all board positions' do
      result = check_status.send(:all_positions)
      expected_positions = (0..7).flat_map { |row| (0..7).map { |col| [row, col] } }
      expect(result).to match_array(expected_positions)
    end
  end
end
