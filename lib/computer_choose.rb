module ComputerChoose
  def choose(color_list)
    computer_choice = Array.new(4)
    computer_choice.map! do |_value|
      color_list[Random.new.rand(5)]
    end
    computer_choice
  end
end
