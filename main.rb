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
  end
  turn
end

def player_turn(board, colors, guess_row, peg_area)
  computer_choice = board.choose(colors)
  i = 0
  loop do
    # This will ensure that during the next iteration, peg area won't have the previous blacks
    peg_area = [nil, nil, nil, nil]
    guess_row = board.guess(guess_row, colors)
    peg_area = board.check_guess(computer_choice, guess_row, peg_area)
    i += 1
    p peg_area
    if peg_area == %w[Red Red Red Red]
      puts "You've won!! The computer choice was #{computer_choice}"
      break
    elsif i >= 12
      puts "The computer choice was actually #{computer_choice}. Sowwy buddy, you've kinda failed..."
      break

    end
  end
end

def computer_turn(board, colors, _guess_row, peg_area, all_guesses)
  player_choice = board.player_choose(colors)
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
