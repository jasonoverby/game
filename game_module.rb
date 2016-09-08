module TheWriter

  def get_name
    puts "Hello, there!"
    puts "What is your name?"
    print "> "
    the_writer["name"] = $stdin.gets.chomp
  end

  # def name
  #   @name
  # end
end

module WriterStuff
  def punctuation
    %w(. ! ? ¡ ¿)
  end

  def filler
    filler_words = %w(Hmmmm Well Er Um Huh Ok)
    puts "#{filler_words[rand(0..filler_words.length - 1)]}..."
  end

  def book_titles
    ["On the Road", "Demian", "Women", "Dune", "Anna Karenina", "Love in the Time of Cholera"]
  end

  def book_authors
    ["Jack Kerouac", "Hermann Hesse", "Charles Bukowski", "Frank Herbert", "Leo Tolstoy", "Garbiel Garcia Marquez"]
  end

  def books
    Hash[book_authors.zip book_titles]
  end

  def get_favorite_book
    puts "Whick of these tomes do you like best?"
    book_array = []
    books.each do |author, title|
      book_array << "'#{title}' by #{author}"
    end
    book_array.each_with_index do |book,index|
      puts "#{index + 1}. #{book}"
    end
    print "> "
    @favorite_book = book_array[$stdin.gets.chomp.to_i - 1]
  end

  def favorite_book
    @favorite_book
  end

  def tools
    %w(computer pen pencil notebook)
  end

  def list_tools
    tools.each_with_index do |tool,index|
      # print " "
      puts "#{index + 1}. #{tool}"
    end
  end

  def get_favorite_tool
    puts "Ok, so you call yourself a writer, right?"
    puts "Which of these is your favorite tool?"
    list_tools
    print "> "
    @favorite_tool = tools[$stdin.gets.chomp.to_i - 1]
  end

  def favorite_tool
    @favorite_tool
  end
end

module Map
  include TheWriter
  # def initialize(first_room)
  #   @first_room = first_room
  # end

  def rooms
    {"bookstore" => BookStore.new,
     "cafe" => Cafe.new, "study" => Study.new, "bathroom" => Bathroom.new}
  end

  def starting_room
    Study.new.enter
  end

  def go_to_room(room)
    rooms[room].enter
  end

  def present_options(one, two, three, four=nil, five=nil, six=nil)
    puts "Select"
    puts "1. #{one}"
    puts "2. #{two}"
    puts "3. #{three}"
    puts "4. #{four}" unless four.nil?
    puts "5. #{five}" unless five.nil?
    puts "6. #{six}" unless six.nil?
    print "> "
  end

end

module Combat
  include WriterStuff
  include TheWriter

  # def determine_hit_points
  #   rand(80..100)
  # end

  def start_combat
    @hit_points = rand(80..100)
    fight_with_an_idea
  end

  def hp
    @hit_points
  end

  def tool
   @tool
  end

  def fight_with_an_idea
    puts "You begin wrestling with an idea."
    puts "You need a tool."
    present_options(tools[0], tools[1], tools[2], tools[3])
    choice = $stdin.gets.chomp.to_i
    @tool = tools[choice-1]
    puts "You have chosen the #{tool}"
    puts "...but the idea is still there."
    puts "...and you have #{hp} hit points"
    present_options("Battle the idea", "Go to the library", "Go to the bookstore")
    choice = $stdin.gets.chomp.to_i
    if choice == 1
      battle
    elsif choice == 2
      go_to_room("library")
    elsif choice == 3
      go_to_room("bookstore")
    else
      puts "You just don't get choices, do you?"
    end

  end

  def battle
    puts "Welcome to the battle of your life."
    idea_hp = rand(30..60)
    puts "The idea has #{idea_hp} hit points."
    puts "Your weapon is the #{tool}"
  end
end

# class Test
#
#   def initialize
#     # variable must be included in initialize or def for
#     # object to have access to it
#     # & must be an instance variable
#     # @punctuation = %w(. ! ?)
#   end
#
#   def greeting(name)
#     # but non-instance variable can be used w/in scope
#     hello = "HELLLLLLOOOOOOO"
#
#
#     puts " #{name}#{punctuation[rand(0..punctuation.length - 1)]}"
#     # TRY WITH %s
#     # puts format("%s, %s%s", test_greeting, name, @punctuation[rand(0..@punctuation.length - 1)])
#     # puts sprintf("%s, %s%s", test_greeting, name, @punctuation[rand(0..@punctuation.length - 1)])
#     # puts "%s, %s%s" % [test_greeting, name, @punctuation[rand(0..@punctuation.length - 1)]]
#     puts hello
#   end
# end
