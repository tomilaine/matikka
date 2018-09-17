#!/usr/bin/ruby

PENALTY = 20

$score = 0
$fails = []
$time_score = nil

def score_title(time_score)
  titles = [60,  "PRO! 👍👍👍👍👍"],
           [80, "GOOD! 👍👍👍👍"],
           [100, "OK! 👍👍👍"],
           [120, "👍👍"],
           [140, "👍"]

  title = titles.find { |title| time_score < title[0] }
  title ? title[1] : "💩"
end

def multiplication_table
  num_as = (1..10).to_a
  num_bs = (1..10).to_a

  arr = []
  num_as.each do |num_a|
    num_bs.each do |num_b|
      arr << [num_a, num_b, num_a * num_b]
    end
  end
  arr
end

def shuffled_multiplication_table
  multiplication_table.shuffle[0..9]
end

def multiplication
  table = shuffled_multiplication_table
  table.each do |row|
    answer = ask("Mitä on #{row[0]} * #{row[1]}?")
    if answer == row[2]
      puts "AIKA PRO!"
    else
      puts "lisää harjoitusta..."
    end
    puts "--------------------------------"
  end
end

def division
  start_time = Time.now
  table = shuffled_multiplication_table
  table.each do |row|
    puts "--------------------------------"
    answer = ask("#{row[2]} : #{row[1]} = ?")
    if answer == row[0]
      puts "AIKA PRO!"
      $score = $score + 1
    else
      puts "lisää harjoitusta... Se oli #{row[0]}"
      $fails << ["#{row[2]} : #{row[1]} = #{row[0]}"]

    end
    puts "Score: #{$score}"
    sleep 0.5
  end
  end_time = Time.now
  $time_score = (end_time - start_time).round
end

def ask(question)
  puts question
  gets.chomp.to_i
end

puts "1. Kertolaskuja"
puts "2. Jakolaskuja"
print "Mitäs laitetaan? "
selection = gets.chomp.to_i
if selection == 1
  multiplication
elsif selection == 2
  division
else
  puts "No ei sit! 💩"
end

penalty_time = $fails.count * PENALTY
final_score = $time_score + penalty_time
title = score_title(final_score)

puts "\n--------------------------------"
puts "Score: #{$score}"
puts "Time: #{$time_score} seconds"
puts "Fails: #{$fails.count} -> Penalty #{penalty_time} sec"
puts "FINAL SCORE: #{final_score} seconds"
puts "That makes you a, #{title}"
unless $fails.empty?
  puts "\nPractice needed with these:"
  $fails.each { |f| puts f }
end
