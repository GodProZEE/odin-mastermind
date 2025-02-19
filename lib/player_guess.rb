module PlayerGuess
  def guess(guess_row, color_list)
    puts "Please enter a color from: "
    color_list.each_with_index do |value, index|
      puts ("#{index}: #{value}")
    end

    for i in 0..3 do
      guess_row[i] = color_list[gets.chomp.to_i]
    end
        
    return guess_row
  end

  def check_guess(computer_choice, guess_row, peg_area)
    if computer_choice == guess_row
      peg_area = ["Red", "Red", "Red", "Red"]
    else
      # This variable is made because values are deleted from it
      # but if it's done with computer_choice, then next iteration will have them deleted
      temp_comp_choice = []
        computer_choice.each do |value|
          temp_comp_choice.append(value)
        end
      guess_row.each_with_index do |value, index|
        
        if temp_comp_choice.include?(value)
          if temp_comp_choice[index] == guess_row[index]
            peg_area[index] = "Red"
            temp_comp_choice[index] = nil
          else
            # This is done to not have numerous 'black' inside peg area
            # due to one color being chosen multiple times
            # if comp choice has just one instance of the color in question

            if temp_comp_choice.count(value) >= guess_row.count(value) && temp_comp_choice.count(value).zero? == false

            peg_area[index] = "Black"
            end
            
          end
          guess_row[guess_row.index(value)] = nil
        else   
          peg_area[index] = nil
        end
        
        
      end
    end
    return peg_area
  end
end
