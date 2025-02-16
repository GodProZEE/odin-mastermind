module ComputerChoose
  def choose(color_list)
    computer_choice = Array.new(4)
    computer_choice.map! do |value|
      color_list[Random.new.rand(5)]
    end
    return computer_choice
  end
end
