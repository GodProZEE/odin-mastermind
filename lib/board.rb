require_relative 'computer_choose'
require_relative 'player_guess'
require_relative 'player_choose'
require_relative 'computer_guess'

class Board
  include ComputerChoose
  include PlayerGuess
  include PlayerChoose
  include ComputerGuess  
  attr_accessor :colors, :guess_row, :peg_area, :all_guesses

  def initialize
    @all_guesses = (Set.new((1111..6666).each { |x| x })).to_a.delete_if {|value| value.to_s.include? '7' or value.to_s.include? '8' or value.to_s.include? '9'}.map! do |value|
      value.digits.reverse.map! do |each_digit|
        each_digit - 1
      end
    end.delete_if {|value| value.to_s.include? '-1'}
    @colors = ["Red", "Blue", "Green", "Magenta", "Yellow", "Black"]

    # This is the actual value, that every possible value gets compared with
    @guess_row = Array.new(4)
    @peg_area = Array.new(4)
  end

  

end

board = Board.new
all_guesses = board.all_guesses
peg_area = board.peg_area
guess_row = ["Red", "Red", "Blue", "Green"]
colors = board.colors
# board.computer_guess(guess_row, possible_guesses, peg_area, colors)
possible_guesses = [[0, 0, 1, 1], [1, 3, 2, 5], [1, 1, 1, 1], [3, 3, 4, 5], [3, 3, 3, 3], [1, 2, 3, 4]]
board.minmax(all_guesses, possible_guesses)

