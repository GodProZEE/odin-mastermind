require_relative 'lib/board'

board = Board.new
colors = board.colors
peg_area = board.peg_area
guess_row = board.guess_row





turn = ''


def ask_player(turn)
  puts "Do you want to choose the code or guess the code? Enter 'Choose' or 'Guess'"
  turn = gets.chomp
  return turn
end


def player_turn(board, colors, guess_row, peg_area)
  computer_choice = board.choose(colors)
  i = 0
  loop do
    guess_row = board.guess(guess_row, colors)
    peg_area = board.check_guess(computer_choice, guess_row, peg_area)
    i += 1
    break if peg_area == ["Red", "Red", "Red", "Red"] or i >= 12
  end
end

def play_game(board, turn, colors, guess_row, peg_area)
  turn = ask_player(turn)
  if turn == "Guess"
    player_turn(board, colors, guess_row, peg_area)
  end
end

play_game(board, turn, colors, guess_row, peg_area)
    

