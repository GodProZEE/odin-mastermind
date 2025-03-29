module PlayerGuess
  def guess(guess_row, color_list)
    puts 'Please enter a color from: '
    color_list.each_with_index do |value, index|
      puts("#{index}: #{value}")
    end

    (0..3).each do |i|
      guess_row[i] = color_list[gets.chomp.to_i]
    end

    guess_row
  end

  def check_guess(choice, guess_row, peg_area)
    if choice == guess_row
      peg_area = %w[Red Red Red Red]
    else
      # This variable is made because values are deleted from it
      # but if it's done with computer_choice, then next iteration will have them deleted
      temp_choice = choice.map do |value|
        value
      end

      temp_guess_row = guess_row.map do |value|
        value
      end

      temp_guess_row.each_with_index do |value, index|
        if temp_choice.include?(value)
          if temp_choice[index] == guess_row[index]
            peg_area[index] = 'Red'
            temp_choice[index] = nil
          elsif temp_choice.count(value) >= temp_guess_row.count(value) && temp_choice.count(value).zero? == false
            # This is done to not have numerous 'black' inside peg area
            # due to one color being chosen multiple times
            # if comp choice has just one instance of the color in question

            peg_area[index] = 'Black'

          end
          temp_guess_row[temp_guess_row.index(value)] = nil
        else
          peg_area[index] = nil
        end
      end
    end
    peg_area.compact.sort
  end
end
