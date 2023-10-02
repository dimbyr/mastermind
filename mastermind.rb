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
    score_table = {right_color_right_position: 0, right_color_wrong_position: 0}
    wrongs_guesses = []
    hiddens = []
    guess.each_with_index do |x, i|
      if @secret_colors[i] == x
        score_table[:right_color_right_position] += 1
      else
        wrongs_guesses << x
        hiddens << @secret_colors[i]
      end
    end
    hiddens.uniq.each do |x|
      score_table[:right_color_wrong_position] += [hiddens.count(x), wrongs_guesses.count(x)].min
    end
    score_table
  end

  def select_random_colors
    4.times do
      @hidden_colors << $color_list.sample(4)
    end
  end
end

# The guesser
class CodeBroker
  attr_accessor :guess

  def initialize
    @guess = [1, 1, 2, 2].map! {|x| $color_list[x-1]}
  end

  def update_guess(feedback)
    # Need to implement a strategy here
    if feedback == [4, 0]
      puts 'Horray!!'
    elsif feedback.sum == 4
      @guess.shuffle!
    else
      @guess = []
      4.times do
        @guess << $color_list.sample
      end
    end
    print @guess
    puts ''
  end
end

# If the guesser is a human
class HumanGuesser < CodeBroker
  def update_guess
    begin
      puts 'Select 4 colors using 4 numbers from 1-6 (NO SPACE).'
      $color_list.each_with_index do |color, index|
        print "#{index + 1}:  #{color},\t"
      end
      choice = gets.chomp.split('').map!(&:to_i)
    end until choice.length == 4 && choice.all? { |x| x >= 1 && x <= 6 }
    @guess = choice.map { |x| $color_list[x-1] }
  end
end

# If the codemaker is a human
class HumanCodeMaker

  def initialize
  end

  def score_a_guess(guess)
    # puts guess
    score = []
    puts 'How many right colors on the right places?'
    score << gets.chomp.to_i
    if score == [4]
      score << 0
    else
      puts 'How many right colors in wrong places?'
      score << gets.chomp.to_i
    end
    score
  end
end

