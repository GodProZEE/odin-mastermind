module PlayerChoose
  def player_choose(color_list)
    player_choice = Array.new(4)
    puts "Please choose your colors for the computer to guess:"
    color_list.each_with_index do |value, index|
      puts "#{index}: #{value}"
    end

    player_choice.map! do |value|
      color_list[gets.chomp.to_i]
    end
    
    return player_choice
  end
end
