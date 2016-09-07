module WriterStuff
  def punctuation
    %w(. ! ? ¡ ¿)
  end

  def filler
    filler_words = %w(Hmmmm Well Er Um Huh Ok)
    puts "#{filler_words[rand(0..filler_words.length - 1)]}..."
  end

  def get_name
    puts "Hello, there!"
    puts "What is your name?"
    print "> "
    @name = $stdin.gets.chomp
  end

  def name
    @name
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
  # def initialize(first_room)
  #   @first_room = first_room
  # end

  def rooms
    {"bookstore" => BookStore.new,
     "cafe" => Cafe.new, "study" => Study.new, "bathroom" => Bathroom.new}
  end

  def starting_room
    BookStore.new.enter
  end

  def go_to_room(room)
    rooms[room].enter
    # Study.new.enter
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
