module PlayerChoose
  def player_choose(color_list, board)
    board.display_options(color_list)

    choice = []

    gets.chomp.split('').map { |value| value.to_i }.each do |index|
      choice << color_list[index]
    end
    choice
  end
end
