# a selector
class CodeMaker
  attr_accessor :secret_colors

  def initialize
    color_list = %w[Red Blue Green Yellow Purple Orange]
    @secret_colors = []
    4.times do
      @secret_colors << color_list.sample
    end
  end

  def score_a_guess(guess)
    score_table = {
      right_color_right_position: 0, 
      right_color_wrong_position: 0,
      wrong_color_wrong_position: 0
      }
    
    guess.each_with_index do |x, i|
      if @secret_colors[i] == x 
        score_table[:right_color_right_position] += 1
      elsif @secret_colors.include?(x)
        score_table[:right_color_wrong_position] += 1
      else 
        score_table[:wrong_color_wrong_position] += 1
      end
    end
    score_table
  end

  def select_random_colors
    4.times do
      @hidden_colors << color_list.sample(4)
    end
  end

end

class CodeBroker
end

mastermind = CodeMaker.new()
guess = %w[Red Blue Green Green]
puts "Your scores are the following:\n #{mastermind.score_a_guess(guess)}"



