# frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board do
  describe '#draw_board' do
    context 'when the board is empty' do
      subject(:empty_board) { described_class.new }

      it 'displays an empty board' do
        expected_output = [[[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']]]

        actual_output = empty_board.draw_board

        expect(actual_output).to eq(expected_output)
      end
    end

    context 'when the board has one piece' do
      it 'displays a board with one piece an X' do
        one_piece_board = described_class.new
        one_piece_board.board[0][0][1] = 'X'

        expected_output = [[[47, 'X'],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']]]

        actual_output = one_piece_board.draw_board

        expect(actual_output).to eq(expected_output)
      end
    end
  end

  describe '#starting_positions' do
    context 'when the board is in starting position' do
      subject(:full_board) { described_class.new }
      it 'displays all pieces in starting positions' do
        full_board.starting_positions
        expected_output = [[[47, '♜'],
                            [46, '♞'],
                            [47, '♝'],
                            [46, '♛'],
                            [47, '♚'],
                            [46, '♝'],
                            [47, '♞'],
                            [46, '♜']],
                           [[46, '♟'],
                            [47, '♟'],
                            [46, '♟'],
                            [47, '♟'],
                            [46, '♟'],
                            [47, '♟'],
                            [46, '♟'],
                            [47, '♟']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' ']],
                           [[46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' '],
                            [46, ' '],
                            [47, ' ']],
                           [[47, '♙'],
                            [46, '♙'],
                            [47, '♙'],
                            [46, '♙'],
                            [47, '♙'],
                            [46, '♙'],
                            [47, '♙'],
                            [46, '♙']],
                           [[46, '♖'],
                            [47, '♘'],
                            [46, '♗'],
                            [47, '♕'],
                            [46, '♔'],
                            [47, '♗'],
                            [46, '♘'],
                            [47, '♖']]]

        expect(full_board.board).to eq(expected_output)
        full_board.draw_board
      end
    end
  end

  describe '#move_piece' do
    context 'moving pawn from starting position' do
      subject(:pawn_move) { described_class.new }
      before do
        pawn_move.starting_positions
        p 'before move'
        pawn_move.draw_board
      end
      it 'will move the white pawn up one' do
        pawn_move.move_piece([6, 0], [5, 0])
        expect(pawn_move.board[5][0][1]).to eq('♙')
        p 'after move'
        pawn_move.draw_board
      end
    end
  end
end
