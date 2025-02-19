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

    peg_area = [0, 0, 0, 0]
    if computer_choice == guess_row
      peg_area = ["Red", "Red", "Red", "Red"]
    else
      temp_comp_choice = []
        computer_choice.each do |value|
          temp_comp_choice.append(value)
        end
      guess_row.each_with_index do |value, index|
        

        p temp_comp_choice
        if temp_comp_choice.include?(value)
          if temp_comp_choice[index] == guess_row[index]
            peg_area[index] = "Red"
            temp_comp_choice[index] = nil
          else
            if temp_comp_choice.count(value) >= guess_row.count(value) && temp_comp_choice.count(value).zero? == false
            puts "For the value #{value}, black is appended"
            peg_area[index] = "Black"
            end
            
          end
          guess_row[guess_row.index(value)] = nil
        else   
          peg_area[index] = nil
        end
        
        puts "Guess row is #{guess_row}"
        puts "Peg area is #{peg_area}"
        
      end
    end
    return peg_area
  end
end
