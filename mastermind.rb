color_list = %w[Red Blue Green Yellow Purple Orange]

# a selector
class Selector
  attr_accessor :hidden_colors

  def initialize
    @hidden_colors = []
  end

  def score_a_guess(guess)
    # check for matches: How many right colors are there?
    # Among the right colors, how many of them are in the right place?
  end

  def select_random_colors
    4.times do
      @hidden_colors << color_list.sample(4)
    end
  end

end