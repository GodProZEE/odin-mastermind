module PlayerGuess
  def guess(guess_row, color_list)
    choice = []

    gets.chomp.split('').map { |value| value.to_i }.each do |index|
      choice << color_list[index]
    end
    choice
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

  def player_guess(board, colors, guess_row, peg_area, computer_choice)
    i = 1
    display_options(colors)
    loop do
      # This will ensure that during the next iteration, peg area won't have the previous blacks
      peg_area = [nil, nil, nil, nil]
      sleep 2 if i != 1
      puts "Turn: #{i}"
      puts 'Your choice: '
      guess_row = board.guess(guess_row, colors)
      peg_area = board.check_guess(computer_choice, guess_row, peg_area)
      player_disp(guess_row, peg_area)
      i += 1

      if peg_area == %w[Red Red Red Red]
        puts "You've won!!"
        display_choice(computer_choice)
        break
      elsif i >= 13
        puts "Sowwy buddy, you've kinda failed..."
        display_choice(computer_choice)
        break
      end
    end
  end

  def player_disp(guess, response)
    print('Your guess                           Response')
    puts ''
    guess.each do |value|
      print value.colorize(value.downcase.to_sym)
      print(' | ')
    end
    response.each do |value|
      print '▆'.colorize(value.downcase.to_sym)
      print(' ')
    end
    puts ''
    puts ''
  end
end
