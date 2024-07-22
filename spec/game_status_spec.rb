# spec/game_status_spec.rb
require 'rspec'
require_relative '../lib/board'
require_relative '../lib/piece'
require_relative '../lib/game_status'

RSpec.describe GameStatus do
  let(:board) { instance_double(Board) }
  let(:game_status) { described_class.new(board) }

  describe '#initialize' do
    it 'initializes with a board and sets check to false' do
      expect(game_status.board).to eq(board)
      expect(game_status.check).to be false
    end
  end

  describe '#check?' do
    let(:king) { double('King', color: :black, instance_of?: true) }
    let(:other_piece) { double('Piece', color: :white, instance_of?: false) }

    before do
      allow(game_status).to receive(:all_valid_moves_on_board).and_return([[0, 0], [1, 1]])
      allow(board).to receive(:piece_at).with([0, 0]).and_return(other_piece)
      allow(board).to receive(:piece_at).with([1, 1]).and_return(king)
    end

    it 'sets check to true if the king is in check' do
      game_status.check?(:white)
      expect(game_status.check).to be true
    end

    it 'does not set check to true if the king is not in check' do
      allow(board).to receive(:piece_at).with([1, 1]).and_return(other_piece)
      game_status.check?(:white)
      expect(game_status.check).to be false
    end
  end

  describe '#all_valid_moves_on_board' do
    let(:piece) { double('Piece', color: :white, position: [0, 0]) }
    let(:empty_piece) { double('EmptyPiece', instance_of?: true) }

    before do
      allow(piece).to receive(:all_valid_moves).with([0, 0]).and_return([[2, 2]]) # Explicitly allow piece to receive all_valid_moves
      allow(game_status).to receive(:all_positions).and_return([[0, 0], [1, 1]])
      allow(board).to receive(:piece_at).with([0, 0]).and_return(piece)
      allow(board).to receive(:piece_at).with([1, 1]).and_return(empty_piece)
    end

    it 'returns all valid moves for the given color' do
      result = game_status.send(:all_valid_moves_on_board, :white)
      expect(result).to eq([[2, 2]])
    end
  end

  describe '#all_positions' do
    it 'returns all board positions' do
      result = game_status.send(:all_positions)
      expected_positions = (0..7).flat_map { |row| (0..7).map { |col| [row, col] } }
      expect(result).to match_array(expected_positions)
    end
  end
end
