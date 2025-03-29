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
    @all_guesses = Set.new((1111..6666).each do |x|
    end).to_a.delete_if { |value| value.to_s.include? '7' or value.to_s.include? '8' or value.to_s.include? '9' }.map! do |value|
      value.digits.reverse.map! do |each_digit|
        each_digit - 1
      end
    end.delete_if { |value| value.to_s.include? '-1' }
    @colors = %w[Red Blue Green Magenta Yellow Black]

    # This is the actual value, that every possible value gets compared with
    @guess_row = Array.new(4)
    @peg_area = Array.new(4)
  end

  def display_choice(choice)
    print("\nSecret Code: ")
    choice.each do |value|
      print(value.colorize(value.downcase.to_sym))
      print(' ')
    end
    puts ''
    puts ''
  end

  def display_options(color_list)
    puts 'Please enter 4 colors in the format XXXX from: '
    color_list.each_with_index do |value, index|
      print("#{index}: #{value}".colorize(value.downcase.to_sym))
      print(' | ')
    end
    puts ''
  end
end
