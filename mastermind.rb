# a selector
class CodeMaker
  attr_accessor :secret_colors
  $color_list = %w[Red Blue Green Yellow Purple Orange]

  def initialize
    @secret_colors = []
    4.times do
      @secret_colors << $color_list.sample
    end
  end

  def score_a_guess(guess)
    score_table = {
      wrong_colors: 0,
      right_color_right_position: 0,
      right_color_wrong_position: 0
      }
    
    (@secret_colors.uniq).each do |x|
      s = (@secret_colors.select {|y| y == x}).length
      g = (guess.select {|y| y == x}).length
      score_table[:wrong_colors] += (s-g).abs
    end

    guess.each_with_index do |x, i|
      if @secret_colors[i] == x 
        score_table[:right_color_right_position] += 1
      end
    end

    score_table[:right_color_wrong_position] = (4 - score_table[:wrong_colors]) - score_table[:right_color_right_position]
    score_table
  end

  def select_random_colors
    4.times do
      @hidden_colors << $color_list.sample(4)
    end
  end

end

class CodeBroker
  attr_accessor :guess
  def initialize
    @guess = []
    4.times do 
      @guess << $color_list.sample
    end
  end

  def update_guess(feedback)
    @gess.map! {|color| $color_list.sample}
  end

end

class HumanGuesser < CodeBroker

  def update_guess()
    puts "Select 4 colors using numbers from 1-6 (NO SPACE). Duplicates are allowed. eg. 1111 is [Red Red Red Red]"
    $color_list.each_with_index do |color, index|
      print "#{index + 1}:  #{color},\t"
    end
    puts "\n"
    choice = gets.chomp.split('').map! {|x| x.to_i}
    until (choice.length == 4 && choice.all? {|x| x >= 1 && x <= 6}) do
      puts "Please enter a sequence of FOUR numbers (no space) between 1-6 to choose 4 colors"
      $color_list.each_with_index do |color, index|
        print "#{index + 1}:  #{color},\t"
      end
      puts "\n"
      choice = gets.chomp.split('').map! {|x| x.to_i}
    end
    @guess = choice.map {|x| $color_list[x-1]}
  end
end

mastermind = CodeMaker.new()
Human = HumanGuesser.new()
track = 0
n = 12
n.times do
  guess = Human.update_guess
  scores = mastermind.score_a_guess(guess)
  puts "Your scores are the following:\n #{scores}"
  if scores[:right_color_right_position] == 4
    puts "Congratulations, You got it! The secret colors are\n #{mastermind.secret_colors}"
    break
  end
  track += 1
  puts "#{n-track} attempts remaining !!! "
end
if track == n 
  puts "Game Over! You could not guess the secret colors\n They are : #{mastermind.secret_colors}"
end
