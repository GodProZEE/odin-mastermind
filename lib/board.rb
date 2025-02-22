require_relative 'computer_choose'
require_relative 'player_guess'
require_relative 'player_choose'

class Board
  include ComputerChoose
  include PlayerGuess
  include PlayerChoose
  attr_accessor :colors, :guess_row, :peg_area

  def initialize
    @colors = ["Red", "Blue", "Green", "Magenta", "Yellow", "Black"]
    @guess_row = Array.new(4)
    @peg_area = Array.new(4)
  end

end

