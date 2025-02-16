require_relative 'lib/board'

board = Board.new
colors = board.colors

computer_choice = board.choose(board.colors)
peg_area = board.peg_area
guess_row = board.guess_row

p computer_choice
board.guess(guess_row, colors)
guess_row = board.guess_row



p board.check_guess(computer_choice, guess_row, peg_area)


