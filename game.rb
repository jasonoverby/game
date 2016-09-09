# goal is the collect tool & name & favorite book & coffee & then go to bathroom

# present_options to give_options
# copy-edit (punctuation)
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
    puts "You have been trying to finish a piece of writing for days..."
    puts "...but you seem to be getting nowhere."
    puts "You have #{$hp} hit points."
    starting_room
  end

end

class BookStore

  def enter
    puts "You are in a bookstore."
    puts "You have #{indefinite_articlerize($tool)}." unless $tool.nil?
    present_options("Look at the shelves", "Get a coffee", "Go to the bathroom")
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
        puts "You drive home."
        go_to_room("study")
      else
        go_to_room("bathroom")
      end
    elsif choice == 2
      go_to_room("cafe")
    else
      go_to_room("bathroom")
    end
  end
end

class Cafe
  def enter
    puts "Ahoy, Matey#{punctuation.sample}"
    puts "You have entered a nautical-themed café."
    puts "Which coffee do you order?"
    coffees = %w(espresso cappuccino coffee nitro frappuccino)
    give_options(coffees)
    choice = $stdin.gets.chomp.to_i - 1
    # DRY up more - coffee(s)
    $coffee = coffees[choice]
    puts "You now have #{indefinite_articlerize($coffee)}!"
    puts "You are well on your way to being a writer!"
    puts "Now what?"
    options = ["Go back to the bookstore","Go to your study","Go to the bathroom"]
    give_options(options)
    # make a method for this
    choice = get_choice
    if choice == 1
      go_to_room("bookstore")
    elsif choice == 2
      go_to_room("study")
    else
      go_to_room("bathroom")
    end
  end
end

class Study
  def enter
    puts "You are in your house in your study."
    puts "You have pocketed #{$book}." unless $book.nil?
    options = ["Work harder#{punctuation.sample}", "Drive to the bookstore", "Go to the bathroom"]
    # present_options("Work harder#{punctuation.sample}", "Drive to the bookstore", "Go to the bathroom")
    give_options(options)
    choice = get_choice
    if choice == 1
      go_to_room("arena")
    elsif choice == 2
      go_to_room("bookstore")
    else
      go_to_room("bathroom")
    end
  end
end

class Bathroom
  def enter
    puts "You have made it to the bathroom!"
    you_are_a_writer = true unless $tool.nil? || $book.nil? || $work.nil? || $coffee.nil?
    if you_are_a_writer
      puts "#{$name}, you have won!"
      puts "You have #{indefinite_articlerize($tool)}, #{$book}, #{indefinite_articlerize($work)}, and #{indefinite_articlerize($coffee)}!"
      puts "You are now a writer!"
      exit(0)
    else
      puts "Time to get down to business."
      present_options("Go to the café", "Go to the study", "Poop")
      choice = $stdin.gets.chomp.to_i
      if choice == 1
        go_to_room("cafe")
      elsif choice == 2
        go_to_room("study")
      else
        go_to_room("bathroom")
      end
    end
  end
end

class Arena
  def enter
    puts "You begin wrestling with an idea."
    puts "You need a tool."
    present_options(tools[0], tools[1], tools[2], tools[3])
    choice = $stdin.gets.chomp.to_i
    $tool = tools[choice-1]
    puts "You have chosen #{indefinite_articlerize($tool)}"
    puts "...but the idea is still there."
    puts "...and you have #{$hp} hit points."
    present_options("Battle the idea", "Go to the bookstore", "Go to the bathroom")
    choice = $stdin.gets.chomp.to_i
    if choice == 1
      battle
    elsif choice == 2
      go_to_room("bookstore")
    else
      go_to_room("bathroom")
    end
  end
end

p = Play.new
p.start
