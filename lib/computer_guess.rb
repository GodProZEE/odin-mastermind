

module ComputerGuess
  include PlayerGuess
  def computer_guess(choice, peg_area)
    possible_guesses = Set.new((1111..6666).each { |x| x })
    
  end
end
