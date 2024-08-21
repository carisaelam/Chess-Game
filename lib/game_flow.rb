# frozen_string_literal: true

require_relative 'piece_mover'
require_relative 'coordinate_converter'
require_relative 'board'
require_relative 'check_status'
require_relative 'serialize'

# handles the flow of game logic and user prompts
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

  # runs game loop until there is a checkmate
  def start
    welcome
    loop do
      player_turn
      toggle_color
      break if check_status.checkmate?(color)
    end
  end

  private

  # prompts user to select start point then runs method to validate input
  def select_start_point
    print "#{color.capitalize}, select a piece: "
    check_start_input(gets.chomp)
  end

  # prompts user to select end point then runs method to validate input
  def select_end_point
    print 'Select an end point: '
    check_alg_input(gets.chomp)
  end

  # checks for pawn promotion and castling
  def check_special_moves(start_point, end_point)
    if pawn?(start_point) && promotion_possible?(color, end_point)
      move_piece(start_point, end_point)
      ask_for_promotion(end_point, color)
    elsif king_or_rook?(start_point) && castling_possible?
      ask_for_castling(start_point, end_point)
    else
      check_for_check(start_point, end_point)
    end
  end

  # returns true if piece at given position is an instance of Pawn
  def pawn?(position)
    @board.piece_at(position).instance_of?(Pawn)
  end

  # checks for pawn promotion status
  def promotion_possible?(color, end_position)
    @board.promotion_possible?(color, end_position)
  end

  # sends desired promotion piece to be promoted
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

  # prompts user to select a promoted piece
  def prompt_for_promotion_pick(color)
    puts "You're getting promoted!!"
    puts "your color is #{color}"
    puts 'Q - Queen, K - Knight, B - Bishop, R - Rook'
    gets.chomp.downcase
  end

  # changes pawn into an instance of selected promoted piece
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

  # returns true if piece at position is an instance of either King or Rook
  def king_or_rook?(position)
    @board.piece_at(position).instance_of?(King) || @board.piece_at(position).instance_of?(Rook)
  end

  # returns true if pieces are positioned for castling
  def castling_possible?
    @board.castle_short_move_available?(color) || @board.castle_long_move_available?(color)
  end

  # prompt for users to confirm or deny castling attempt
  def ask_for_castling(start_position, end_position)
    puts 'Do you want to castle? Y/N'
    input = gets.chomp.downcase

    if input == 'y'
      perform_castling
    else
      check_for_check(start_position, end_position)
    end
  end

  # performs castle move if selected by user
  def perform_castling
    if @board.castle_short_move_available?(color)
      @piece_mover.perform_short_castle(color)
    elsif @board.castle_long_move_available?(color)
      @piece_mover.perform_long_castle(color)
    else
      puts 'Castling is not available'
    end
  end

  # ensures move would not put your own king in check
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

  # prompt to alert user their king would be in check by the attempted move
  def king_in_check_prompt(start_point, end_point)
    puts 'That would put your king in check. Try again.'
    check_status.reset_check
    move_piece(end_point, start_point) # revert the move
    check_status.reset_check # reset check to false
    print 'Select a piece: '
  end

  # checks for save, then returns input converted into numeric notation after some validation checks
  def check_start_input(input)
    save_game if input.downcase == 'save'
    alg_cleared = check_alg_input(input)

    until check_piece_color(alg_cleared)
      puts 'Not your piece. Pick again'
      input = gets.chomp
      alg_cleared = check_alg_input(input)
    end

    alg_cleared
  end

  # returns true if piece color matches color variable
  def check_piece_color(input)
    piece = board.piece_at(input)
    piece && piece.color == color
  end

  # ensures input is a square on the board and then sends input to notation converter
  def check_alg_input(input)
    until ('a'..'h').include?(input[0]) && (1..8).include?(input[1].to_i)
      puts "Please enter a valid coordinate (e.g., 'e2'):"
      input = gets.chomp
    end

    coordinate_converter.convert_from_alg_notation(input)
  end

  # ensures move is valid and triggers method to actually move the piece
  def move_piece(start_position, end_position)
    unless piece_mover.validate_move(start_position, end_position)
      puts 'Not a valid move for that piece. Pick another move'
      turn_piece_selection
    end

    piece_mover.move_piece(start_position, end_position)
  end

  # SIMPLE HELPER METHODS
  def save_game
    puts 'Name your saved game. No spaces.'
    to_yaml(gets.chomp)
    puts 'Your game has been saved!'
  end

  def toggle_color
    @color = @color == :black ? :white : :black
  end

  def player_turn
    turn_information
    turn_check_status # ensures player is not in check or checkmate
    turn_piece_selection # collects move
    board.print_board
  end

  def welcome
    puts "Welcome to Chess!\n\n"
    puts "Select pieces by typing in coordinates letter first (ex. 'a2', 'e7', 'c8').\n\n"
    puts "First, select the piece you want to move. Then, select the square you want to move it to.\n\n"
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

    puts "#{color.capitalize}: You are in CHECK. You must get out of check"
    puts 'GAME OVER' if check_status.checkmate?(color) == true
  end

  def turn_piece_selection
    start_point = select_start_point
    end_point = select_end_point
    check_special_moves(start_point, end_point) # diverts either to special move options or a check for check status
  end
end
