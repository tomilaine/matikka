#!/usr/bin/ruby

LOWEST_NUMBER = 1
HIGHEST_NUMBER = 10

QUESTIONS = 10
PENALTY = 20

$score = 0
$fails = []
$time_score = nil

def score_title(time_score)
  titles = [60,  "PRO! 👍👍👍👍👍"],
           [80, "HYVÄ! 👍👍👍👍"],
           [100, "OK! 👍👍👍"],
           [120, "👍👍"],
           [200, "👍"]

  title = titles.find { |title| time_score < title[0] }
  title ? title[1] : "💩"
end

def multiplication_table
  number_pairs = (LOWEST_NUMBER..HIGHEST_NUMBER).to_a.permutation(2)
  number_pairs.map{ |number_pair| number_pair << number_pair[0] * number_pair[1] }
end

def rows
  multiplication_table.shuffle[0..QUESTIONS-1]
end

def multiplication(row)
  ["#{row[0]} * #{row[1]}", row[2]]
end

def division(row)
  ["#{row[2]} : #{row[1]}", row[0]]
end

def ask(question, answer)
  puts "\n--------------------------------"
  puts "Kysymys #{$score + $fails.count + 1}/#{QUESTIONS}"
  puts "--------------------------------"
  puts question + " = ?"
  print "Vastaus: "
  if answer == gets.chomp.to_i
    puts "AIKA PRO!"
    $score = $score + 1
    puts "Score: #{$score}"
  else
    puts "lisää harjoitusta... Se oli #{answer}"
    $fails << "#{question} = #{answer}"
  end
  sleep 0.3
end

# Main

puts "1. Kertolaskuja"
puts "2. Jakolaskuja"
print "Mitäs laitetaan? "
selection = gets.chomp.to_i

if selection == 1
  questions = rows.map { |row| multiplication(row) }
elsif selection == 2
  questions = rows.map { |row| division(row) }
else
  puts "No ei sit! 💩"
  exit
end

start_time = Time.now
questions.each { |question| ask(question[0], question[1]) }
end_time = Time.now

time_score = (end_time - start_time).round
penalty_time = $fails.count * PENALTY
final_score = time_score + penalty_time
title = score_title(final_score)

puts "\n--------------------------------"
puts "Score: #{$score}"
puts "Time: #{$time_score} seconds"
puts "Fails: #{$fails.count} -> Penalty #{penalty_time} sec"
puts "FINAL SCORE: #{final_score} seconds"
puts "Olet siis, #{title}"
unless $fails.empty?
  puts "\nHarjoittele näitä:"
  $fails.each { |f| puts f }
end
