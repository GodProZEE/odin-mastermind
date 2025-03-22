require_relative 'player_guess'

module ComputerGuess
  include PlayerGuess
  def computer_guess(player_choice, possible_guesses, peg_area, colors)
    # This is to keep track of all the codes and keep only the unused codes to match in Knuth's algorithm
    all_guesses = []
    possible_guesses.each do |value|
      all_guesses << value
    end
    impossible_codes = []
    i = 0
    guess = 7
    color_of_current_guess = get_colors_from_numbers(possible_guesses[guess], colors)
    loop do
      
      response = check_guess(color_of_current_guess, player_choice, peg_area)
      if response == ["Red", "Red", "Red", "Red"]
        break
      else
        remove_from_array(possible_guesses, impossible_codes, response, colors, color_of_current_guess, peg_area)
        all_guesses.delete_at(7)
        puts all_guesses.count
        break
      end
        
    end
  end

      
  def get_colors_from_numbers(array, colors)
    color_array = []
    array.each do |number|
      color_array << colors[number]
    end
    return color_array
  end

  def remove_from_array(possible_guesses, impossible_codes, response, colors, color_of_current_guess, peg_area)
    # Just trying to use reduce function to be more familiar with its working
    impossible_codes = possible_guesses.reduce(impossible_codes) do |array, possible_element|
      color_of_possible_element = get_colors_from_numbers(possible_element, colors)
      # Array of nils is provided for guess-check because peg area modification does NOT reset it for next iteration
      temp_response = check_guess(color_of_possible_element, color_of_current_guess, [nil, nil, nil, nil])
      if temp_response != response
        impossible_codes << possible_element
      end

      impossible_codes
    end

    impossible_codes.each do |code|
      possible_guesses.delete(code)
    end
      
    
  end
    
  def get_score(guess, possible_guesses)
    score_counter = Hash.new(0)
    possible_guesses.each do |value|
      response = check_guess(value, guess, [nil, nil, nil, nil])
      score_counter[response] += 1
    end

    max_remaining = get_max_from_hash(score_counter)
  end

  def get_max_from_hash(hash)
    max = 0
    hash.each_value { |value| max = value > max ? value : max }
    return max
  end
    

end


