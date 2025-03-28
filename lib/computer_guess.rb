require_relative 'player_guess'

module ComputerGuess
  include PlayerGuess
  def computer_guess(player_choice, all_guesses, peg_area, colors)
    # This is to keep track of all the codes and keep only the unused codes to match in Knuth's algorithm
    possible_guesses = []
    all_guesses.each do |value|
      possible_guesses << value
    end
    impossible_codes = []
    i = 0
    guess = 7
    color_of_current_guess = get_colors_from_numbers(possible_guesses[guess], colors)
    loop do
      
      response = check_guess(color_of_current_guess, player_choice, [nil, nil, nil, nil])
      if response == ["Red", "Red", "Red", "Red"]
        p color_of_current_guess
        p i
        break
      else
        remove_from_array(possible_guesses, impossible_codes, response, colors, color_of_current_guess, peg_area)
        all_guesses.delete_at(guess)
        next_guess = minmax(all_guesses, possible_guesses)
        guess = all_guesses.index(next_guess)
        p next_guess
        color_of_current_guess = get_colors_from_numbers(next_guess, colors)
      end
      i += 1
      p i
      break if i >= 12
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

      #.compact.sort is used with both temp_response and response because
      # B,B,R, nil and R, nil, BB are the same responses, and sort doesn't work with nil
      # so nil must be removed and then they must be sorted to compare
      # this makes sure that responses are equal by value and not by places too
      temp_response = check_guess(color_of_possible_element, color_of_current_guess, [nil, nil, nil, nil]).compact.sort
      if temp_response != response.compact.sort
        impossible_codes << possible_element
      end

      impossible_codes
    end

    impossible_codes.each do |code|
      possible_guesses.delete(code)
    end
      
    
  end
  
  def get_score(guess, possible_guesses)
    # Keeping a tally for the REMAINING codes in the possible guesses
    # for a given outcome. The highest value is the worst case for that guess.
    score_counter = Hash.new(0)
    possible_guesses.each do |value|
      response = check_guess(value, guess, [nil, nil, nil, nil])
      # The count is for the NON eliminated codes, because codes with the same response means that they are the possible codes
      # As such, they will not be the eliminated ones.
      score_counter[response.compact.sort] += 1
    end
    # This gets the worst response to minimize the maximum later.
    # Code's score in this function is the max codes that will remain
    max_remaining = get_max_from_hash(score_counter)
  end

  def get_max_from_hash(hash)
    max = 0
    hash.each_value { |value| max = value > max ? value : max }
    return max
  end

  def max_for_each_guess(all_guesses, possible_guesses)
    max_tally = Hash.new(0)
    all_guesses.each do |code|
      # Getting the worst responses for EACH code
      max_tally[code] = get_score(code, possible_guesses)
    end
    return max_tally
  end

  def get_min_max_values(max_tally)
    # Lowest worst response (this is the number of codes that will remain, lower = better)
    min_value = get_min_from_hash(max_tally)
    mini_max_codes = []
    max_tally.each_pair do |key, value|
      if value == min_value
        # Adding to the array all the codes with the lowest worst response
        mini_max_codes << key
      end
    end
    return mini_max_codes
  end

  def get_min_from_hash(hash)
    min = hash.values.first
    hash.each_value { |value| min = value < min ? value : min }
    return min
  end
    

  def minmax(all_guesses, possible_guesses)
    max_tally = max_for_each_guess(all_guesses, possible_guesses)
    min_max_array = get_min_max_values(max_tally)
    next_guess = choose_value_from_min_max_array(min_max_array, possible_guesses)
    
  end


  def choose_value_from_min_max_array(array, possible_guesses)
    array.sort.each do |value|
      if possible_guesses.include?(value)
        
        return value
        break
        
      else
        next
      end
    end
    return array[0]
  end
end

