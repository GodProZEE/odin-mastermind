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
      guess_row.each_with_index do |value, index|
        if computer_choice.include?(value)
          if computer_choice[index] == guess_row[index]
            peg_area[index] = "Red"
          else
            if computer_choice.count(value) >= guess_row.count(value) && computer_choice.count(value).zero? == false
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
