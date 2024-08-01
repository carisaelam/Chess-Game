# frozen_string_literal: true

require_relative 'piece_mover'
require_relative 'coordinate_converter'
require_relative 'board'
require_relative 'check_status'
require_relative 'serialize'

# handles the flow of game logic
class GameFlow
  include Serialize

  attr_reader :board, :piece_mover, :coordinate_converter, :check_status
  attr_accessor :color

  def initialize(board, piece_mover, coordinate_converter, check_status)
    @board = board
    @piece_mover = piece_mover
    @coordinate_converter = coordinate_converter
    @check_status = check_status
    @color = :white
  end

  # runs game
  def start
    welcome
    loop do
      player_turn
      toggle_color
      break if check_status.checkmate?(color)
    end
  end

  private

  def save_game
    puts 'Name your saved game. No spaces.'
    to_yaml(gets.chomp)
    puts 'Your game has been saved!'
  end

  def player_turn
    turn_information
    turn_check_status
    turn_piece_selection
    board.print_board
  end

  def welcome
    puts "Welcome to Chess!\n\n"
    puts "Player 1 is white, and Player 2 is black.\n\n"
    load_or_new
    puts "New Game!\n\nType save at the start of any move to save your game."
    board.print_board
  end

  def turn_information
    puts
    puts "It is #{color.capitalize}'s turn"
  end

  def turn_check_status
    return unless check_status.check?(color) == true

    p "#{color.capitalize}: You are in CHECK. You must get out of check"
    p 'GAME OVER' if check_status.checkmate?(color) == true
  end

  def turn_piece_selection
    start_point = select_start_point
    end_point = select_end_point
    check_special_moves(start_point, end_point)
  end

  def select_start_point
    print "#{color.capitalize}, select a piece: "
    check_start_input
  end

  def select_end_point
    print 'Select an end point: '
    check_alg_input(gets.chomp)
  end

  # checks for pawn promotion and castling
  def check_special_moves(start_point, end_point)
    if pawn?(start_point) && promotion_possible?(color, end_point)
      move_piece(start_point, end_point)
      ask_for_promotion(end_point, color)
    elsif king_or_rook?(start_point) && castling_possible?(start_point, end_point)
      ask_for_castling(start_point, end_point)
    else
      check_for_check(start_point, end_point)
    end
  end

  def pawn?(position)
    @board.piece_at(position).instance_of?(Pawn)
  end

  def promotion_possible?(color, end_position)
    @board.promotion_possible?(color, end_position)
  end

  def ask_for_promotion(position, color)
    input = prompt_for_promotion_pick(color)
    piece_selected = select_a_piece(input, position)
    perform_promotion(position, color, piece_selected)
  end

  # takes user input and runs ask_for_promotion if invalid input
  def select_a_piece(input, position)
    piece_names = {
      'q' => 'Queen',
      'k' => 'Knight',
      'b' => 'Bishop',
      'r' => 'Rook'
    }

    piece_names[input] || ask_for_promotion(position, color)
  end

  def prompt_for_promotion_pick(color)
    puts "You're getting promoted!!"
    puts "your color is #{color}"
    puts 'Q - Queen, K - Knight, B - Bishop, R - Rook'
    gets.chomp.downcase
  end

  def perform_promotion(position, color, piece_selected)
    piece_classes = {
      'Queen' => Queen,
      'Knight' => Knight,
      'Bishop' => Bishop,
      'Rook' => Rook
    }

    piece_class = piece_classes[piece_selected]
    return unless piece_class

    piece = piece_class.new(color, position, board)
    @board.place_piece(piece, position)
  end

  def king_or_rook?(position)
    @board.piece_at(position).instance_of?(King) || @board.piece_at(position).instance_of?(Rook)
  end

  def castling_possible?(_start_position, _end_position)
    @board.castle_short_move_available?(color) || @board.castle_long_move_available?(color)
  end

  def ask_for_castling(start_position, end_position)
    puts 'Do you want to castle? Y/N'
    input = gets.chomp.downcase

    if input == 'y'
      perform_castling
    else
      check_for_check(start_position, end_position)
    end
  end

  def perform_castling
    if @board.castle_short_move_available?(color)
      @piece_mover.perform_short_castle(color)
    elsif @board.castle_long_move_available?(color)
      @piece_mover.perform_long_castle(color)
    else
      puts 'Castling is not available'
    end
  end

  def toggle_color
    @color = @color == :black ? :white : :black
  end

  # actually moves piece
  def check_for_check(start_point, end_point)
    # loop to check for check
    loop do
      move_piece(start_point, end_point) # move the piece

      break unless check_status.check?(color) # stop here unless the move would put your king in check

      # if move puts king in check...
      king_in_check_prompt(start_point, end_point)

      # re-do select move and loop again
      start_point = check_start_input
      print 'Select an end point: '
      end_point = check_alg_input(gets.chomp)
    end
  end

  def king_in_check_prompt(start_point, end_point)
    puts 'That would put your king in check. Try again.'
    check_status.reset_check
    move_piece(end_point, start_point) # revert the move
    check_status.reset_check # reset check to false
    print 'Select a piece: '
  end

  def check_start_input
    input = gets.chomp
    save_game if input.downcase == 'save'
    alg_cleared = check_alg_input(input)

    until check_piece_color(alg_cleared)
      puts 'Not your piece. Pick again'
      input = gets.chomp
      alg_cleared = check_alg_input(input)
    end

    alg_cleared
  end

  def check_piece_color(input)
    piece = board.piece_at(input)
    piece && piece.color == color
  end

  def check_alg_input(input)
    until ('a'..'h').include?(input[0]) && (1..8).include?(input[1].to_i)
      puts "Please enter a valid coordinate (e.g., 'e2'):"
      input = gets.chomp
    end

    coordinate_converter.convert_from_alg_notation(input)
  end

  def move_piece(start_position, end_position)
    unless piece_mover.validate_move(start_position, end_position)
      puts 'Not a valid move for that piece. Pick another move'
      turn_piece_selection
    end

    piece_mover.move_piece(start_position, end_position)
  end
end
