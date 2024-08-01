# frozen_string_literal: true

require 'fileutils'

require 'yaml'

# handles save and load functionality
module Serialize
  def load_game
    if File.exist?('saved_games') && !Dir.empty?('saved_games')
      puts "Saved files: #{Dir.children('saved_games').join(', ')}"
      puts 'Type the name of your game (without the .yml)'
      filename = gets.chomp
      from_yaml(filename)
    else
      puts "No saved games\n\n"
      nil
    end
  end

  def to_yaml(filename)
    FileUtils.mkdir_p('saved_games')
    File.open("saved_games/#{filename}.yml", 'w') do |file|
      YAML.dump({
                  board: @board,
                  piece_mover: @piece_mover,
                  coordinate_converter: @coordinate_converter,
                  check_status: @check_status
                }, file)
    end
    puts "\nGame Saved"
  end

  def from_yaml(filename)
    f = YAML.safe_load(File.read("saved_games/#{filename}.yml"),
                       permitted_classes: [Board, PieceMover, CoordinateConverter, CheckStatus, Symbol, Rook, Knight, Bishop, Queen, King, Pawn, EmptyPiece], aliases: true)
    @board = f[:board]
    @piece_mover = f[:piece_mover]
    @coordinate_converter = f[:coordinate_converter]
    @check_status = f[:check_status]
    puts "\nGame Loaded"
  end

  def load_or_new
    puts 'Type "load" to load a game or "new" to start a new game!'
    selection = gets.chomp
    puts ' '
    selection.strip.downcase == 'load' ? load_game : return
  end
end
