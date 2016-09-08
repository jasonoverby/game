module WriterStuff

  def punctuation
    %w(. ! ? ¡ ¿)
  end

  def indefinite_articlerize(word)
    %w(a e i o u).include?(word[0].downcase) ? "an #{word}" : "a #{word}"
  end

  def filler
    filler_words = %w(Hmmmm Well Er Um Huh Ok)
    puts "#{filler_words[rand(0..filler_words.length - 1)]}..."
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

  def give_options(array)
    puts "Select"
    puts "1. #{array[0].capitalize}"
    puts "2. #{array[1].capitalize}"
    puts "3. #{array[2].capitalize}"
    puts "4. #{array[3].capitalize}" unless array[3].nil?
    puts "5. #{array[4].capitalize}" unless array[4].nil?
    puts "6. #{array[5].capitalize}" unless array[5].nil?
    print "> "
  end

  def get_choice
    $stdin.gets.chomp.to_i
  end

  def get_choice_minus_one
    get_choice - 1
  end

  def get_name
    puts "Hello, there!"
    puts "What is your name?"
    print "> "
    $name = $stdin.gets.chomp
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
    present_options(book_array[0], book_array[1], book_array[2], book_array[3], book_array[4], book_array[5])
    $book = book_array[($stdin.gets.chomp.to_i - 1)]
  end

  def tools
    %w(computer pen eraser pencil notebook)
  end

  def get_favorite_tool
    puts "Ok, so you call yourself a writer, right?"
    puts "Which of these is your favorite tool?"
    present_options("computer", "pen", "pencil", "notebook")
    $tool = tools[$stdin.gets.chomp.to_i - 1]
  end
end

module Combat
  include WriterStuff

  def battle
    puts "Welcome to the battle of your life."
    @idea_hp = rand(30..60)
    puts "The idea has #{@idea_hp} hit points."
    puts "Your weapon is the #{$tool}."
    while $hp > 0 && @idea_hp > 0
      writer_gets_hit
      $hp > 0 ? idea_gets_hit : next
    end
    if @idea_dies
      post_battle
    else
      puts "You spiral into a depression..."
      puts "...and die :("
    end
  end

  def post_battle
    works = %w(novel story poem pamphlet manual editorial)
    puts "You made it out alive!"
    $work = works[rand(0..works.length - 1)]
    puts "You have written #{indefinite_articlerize($work)}."
    present_options("Go to the bookstore", "Go to the bathroom", "Fight again")
    choice = $stdin.gets.chomp.to_i
    if choice == 1
      go_to_room("bookstore")
    elsif choice == 2
      go_to_room("bathroom")
    else
      battle
    end
  end

  def writer_gets_hit
    hits = ["The idea sucker punches you!",
            "The idea smacks you upside the head",
            "The idea loves you up.  NOT!",
            "The idea kicks you in the face",
            "The idea sweeps the leg!"]
    puts hits[rand(0..hits.length - 1)]
    damage = rand(0..20)
    damage <= $hp ? $hp -= damage : $hp = 0
    puts "You lose #{damage} hit points and now have #{$hp}!"
  end

  def idea_gets_hit
    hits = ["Your #{$tool} flays the idea!",
            "You sneak up behind the idea and BAM!",
            "You write the best sentence known to man!",
            "You oscillate wildly and..."]
    puts hits[rand(0..hits.length - 1)]
    damage = rand(0..20)
    damage <= @idea_hp ? @idea_hp -= damage : @idea_hp = 0
    puts "The idea loses #{damage} hit points and now only has #{@idea_hp}!"
    @idea_dies = true unless @idea_hp > 0
  end
end

module Map
  include WriterStuff
  include Combat

  def rooms
    {"bookstore" => BookStore.new,
     "cafe" => Cafe.new, "study" => Study.new, "bathroom" => Bathroom.new, "arena" => Arena.new}
  end

  def starting_room
    Study.new.enter
  end

  def go_to_room(room)
    rooms[room].enter
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
