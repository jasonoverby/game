# add combat module
# goal is the collect tools & name favorite book
# and write something to become a writer

$LOAD_PATH << '.'
require "game_module"
include WriterStuff
include Map
include Combat
include TheWriter

class Play

  def the_writer
    {"name" => nil, "tool" => nil, "favorite_book" => nil}
  end

  def start
    get_name
    puts the_writer
    # puts "OK, #{the_writer["name"]}..."

    # get_favorite_tool
    # puts "You like to use a #{favorite_tool}?"
    # filler
    # puts "I guess that's cool.  It takes all kinds."
    # puts rooms["study"].inspect
    # @map.go_to_room("study")
    starting_room
  end

end

class Room
end

class BookStore < Room

  def enter
    puts "You are in a bookstore."
    puts "You have a #{tool}" unless tool.nil?
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
      puts "You like #{favorite_book}?"
      filler
      puts "What do you do now?"
      action = $stdin.gets.chomp.downcase
      if action.include?("read")
        puts "Your can read?!?"
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

class Cafe < Room
  def enter
    puts "You have entered a nautical-themed café"
    puts "Ahoy, Matey!"
  end
end

class Study < Room
  def enter
    puts "You are in your house in your study."
    puts "You have been trying to finish a piece of writing for days,"
    puts "but you seem to be getting nowhere."
    # work harder == combat module
    present_options("Work harder!", "Go to the bathroom.", "Drive to the bookstore.")
    choice = $stdin.gets.chomp.to_i
    if choice == 1
      start_combat
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
    puts "Time to get down to business."
  end
end

class Library < Room
  def enter
    puts "You enter the library and see more books than you ever have in your life"
  end
end

p = Play.new
p.start
