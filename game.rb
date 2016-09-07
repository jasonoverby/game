$LOAD_PATH << '.'
require "game_module"
include WriterStuff

class Test

  def initialize
    # variable must be included in initialize or def for
    # object to have access to it
    # & must be an instance variable
    # @punctuation = %w(. ! ?)
  end

  def greeting(name)
    # but non-instance variable can be used w/in scope
    hello = "HELLLLLLOOOOOOO"


    puts " #{name}#{punctuation[rand(0..punctuation.length - 1)]}"
    # TRY WITH %s
    # puts format("%s, %s%s", test_greeting, name, @punctuation[rand(0..@punctuation.length - 1)])
    # puts sprintf("%s, %s%s", test_greeting, name, @punctuation[rand(0..@punctuation.length - 1)])
    # puts "%s, %s%s" % [test_greeting, name, @punctuation[rand(0..@punctuation.length - 1)]]
    puts hello
  end
end

class Play
  def initialize(map)
    @map = map
  end

  def start
    get_name
    puts "OK, #{name}..."

    # get_favorite_tool
    # puts "You like to use a #{favorite_tool}?"
    # filler
    # puts "I guess that's cool.  It takes all kinds."

    @map.go_to_room("bookstore")
  end

  def writer
    [name, favorite_book, favorite_tool]
  end

end

class Room
end

class BookStore < Room

  def enter
    puts "You are in a bookstore."
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
      else
        puts "I don't understand!"
      end
    else
      puts "You are dumb!"
    end
  end
end

class Cafe < Room
  def enter
    puts "You have entered a pirate-themed café"
    puts "Ahoy, Matey!"
  end
end

class Study < Room
end

class Library < Room
end

class Map
  # def initialize(first_room)
  #   @first_room = first_room
  # end

  def rooms
    {"bookstore" => BookStore.new.enter,
     "cafe" => Cafe.new.enter}
  end

  # def starting_room
  #   rooms.find(@first_room)
  # end

  def go_to_room(room)
    rooms.find(room)
  end
end

m = Map.new
p = Play.new(m)
p.start
