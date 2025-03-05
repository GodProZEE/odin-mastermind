require_relative 'computer_choose'
require_relative 'player_guess'
require_relative 'player_choose'
require_relative 'computer_guess'

class Board
  include ComputerChoose
  include PlayerGuess
  include PlayerChoose
  include ComputerGuess  
  attr_accessor :colors, :guess_row, :peg_area, :possible_guesses

  def initialize
    @possible_guesses = (Set.new((1111..6666).each { |x| x })).to_a.delete_if {|value| value.to_s.include? '7' or value.to_s.include? '8' or value.to_s.include? '9'}.map! do |value|
      value.digits.reverse.map! do |each_digit|
        each_digit - 1
      end
    end.delete_if {|value| value.to_s.include? '-1'}
    @colors = ["Red", "Blue", "Green", "Magenta", "Yellow", "Black"]
    @guess_row = Array.new(4)
    @peg_area = Array.new(4)
  end

  

end

p Board.new.possible_guesses.count
