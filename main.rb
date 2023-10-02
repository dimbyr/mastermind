require_relative "mastermind"

# Play a round allowing n=12 guesses.
color_list = %w[Red Blue Green Yellow Purple Orange]
codemakers = [HumanCodeMaker.new, CodeMaker.new]
guessers = [CodeBroker.new, HumanGuesser.new]

puts 'Do you want to be a code maker or a code broker'
puts '1. Code maker'
puts '2. Code broker'

p = gets.chomp.to_i - 1

code_maker = codemakers[p]
guesser = guessers[p]

track = 0
n = 12
if p == 1
  n.times do
    guess = guesser.update_guess
    scores = code_maker.score_a_guess(guess)
    puts "Your scores are the following:\n #{scores}"
    if scores[:right_color_right_position] == 4
      puts "Congratulations, You got it! The secret colors are\n #{code_maker.secret_colors}"
      break
    end
    track += 1
    puts "#{n-track} attempts remaining !!! "
  end

  puts "Game Over! You could not guess the secret colors\n They are : #{code_maker.secret_colors}" if track == n
else
  puts "Think of four colors in #{color_list}"
  puts 'Duplicates are allowed'
  puts 'Write them down in order somewhere! I am going to read your mind! When you are done, press Enter.'
  gets
  guess = guesser.guess
  print guess
  puts ''
  n.times do
    score = code_maker.score_a_guess(guess)
    if score == [4, 0]
      puts 'Yaaaaay !!! '
      break
    else
      guess = guesser.update_guess(score)
    end
  end
end
