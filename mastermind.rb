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
    @guess = []
    4.times do
      @guess << $color_list.sample
    end
  end

  def update_guess(feedback)
    # Need to implement a strategy here
    @gess.map! {|color| $color_list.sample}
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
    @guess = choice.map {|x| $color_list[x-1]}
  end
end

# Play a round allowing n=12 guesses.
mastermind = CodeMaker.new
Human = HumanGuesser.new
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
puts "Game Over! You could not guess the secret colors\n They are : #{mastermind.secret_colors}" if track == n 

