# goal is the collect tool & name & favorite book & then go to bathroom
# and write something to become a writer
# bathroom gives options
# if you don't 'read' after selecting a book you go somewhere
# clean up

$LOAD_PATH << '.'
require "game_module"
include WriterStuff
include Map
include Combat

class Play

  def start
    get_name
    $hp = rand(80..100)
    puts "OK, #{$name}..."
    puts "You have #{$hp} hit points."
    starting_room
  end

end

class BookStore

  def enter
    puts "You are in a bookstore."
    puts "You have a #{$tool}" unless $tool.nil?
    puts "What do you do?"
    puts "1. Look at the shelves"
    puts "2. Get a coffee"
    puts "3. Go to the bathroom"
    print "> "
    choice = $stdin.gets.chomp.to_i

    if choice == 1
      puts "You languidly peruse the particle board stacks."
      puts "Some books on an end cap catch your eye..."
      get_favorite_book
      filler
      puts "You like #{$book}?"
      filler
      puts "You put it in your pocket."
      puts "What do you do now?"
      action = $stdin.gets.chomp.downcase
      if action.include?("read")
        puts "Your can read?!?"
        puts "You drive home"
        go_to_room("study")
      else
        puts "I don't understand!"
      end
    elsif choice == 2
      go_to_room("cafe")
    elsif choice == 3
      go_to_room("bathroom")
    else
      puts "You are dumb!"
    end
  end
end

class Cafe
  def enter
    puts "You have entered a nautical-themed café"
    puts "Ahoy, Matey!"
  end
end

class Study
  def enter
    puts "You are in your house in your study."
    puts "You have pocketed #{$book}" unless $book.nil?
    puts "You have been trying to finish a piece of writing for days,"
    puts "but you seem to be getting nowhere."
    # work harder == combat module
    present_options("Work harder!", "Go to the bathroom.", "Drive to the bookstore.")
    choice = $stdin.gets.chomp.to_i
    if choice == 1
      go_to_room("arena")
    elsif choice == 2
      go_to_room("bathroom")
    elsif choice == 3
      go_to_room("bookstore")
    else
      puts "I don't gettit!"
    end
  end

  def write
    puts "You can't stop writing!"
  end
end

class Bathroom
  def enter
    puts "You have won!  You are now a writer!" unless $tool.nil? || $book.nil? || $work.nil?
    puts "Time to get down to business."
  end
end

class Arena
  def enter
    puts "You begin wrestling with an idea."
    puts "You need a tool."
    present_options(tools[0], tools[1], tools[2], tools[3])
    choice = $stdin.gets.chomp.to_i
    $tool = tools[choice-1]
    puts "You have chosen the #{$tool}"
    puts "...but the idea is still there."
    puts "...and you have #{$hp} hit points"
    present_options("Battle the idea", "Go to the bathroom", "Go to the bookstore")
    choice = $stdin.gets.chomp.to_i
    if choice == 1
      battle
    elsif choice == 2
      go_to_room("bathroom")
    elsif choice == 3
      go_to_room("bookstore")
    else
      puts "You just don't get choices, do you?"
    end
  end
end

p = Play.new
p.start
