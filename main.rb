require_relative 'lib/board'
require 'bundler/setup'
require 'colorize'

# (%w[Blue Red Green].each { |value| puts value.colorize(value.downcase.to_sym) })

board = Board.new
colors = board.colors
peg_area = board.peg_area
guess_row = board.guess_row
all_guesses = board.all_guesses

def ask_player
  turn = gets.chomp.downcase
  if turn != 'guess' && turn != 'choose'
    puts 'Oopsies! You might have misspelled something there. Please enter it again'
    ask_player
  else
    turn
  end
end

def player_turn(board, colors, guess_row, peg_area)
  computer_choice = board.choose(colors)
  board.player_guess(board, colors, guess_row, peg_area, computer_choice)
end

def computer_turn(board, colors, _guess_row, peg_area, all_guesses)
  player_choice = board.player_choose(colors, board)
  board.display_choice(player_choice)
  board.computer_guess(player_choice, all_guesses, peg_area, colors)
end

def play_game(board, colors, guess_row, peg_area, all_guesses)
  puts "Do you want to choose the code or guess the code? Enter 'Choose' or 'Guess'"
  turn = ask_player
  if turn.downcase == 'guess'
    player_turn(board, colors, guess_row, peg_area)
  else
    computer_turn(board, colors, guess_row, peg_area, all_guesses)
  end
end

play_game(board, colors, guess_row, peg_area, all_guesses)
