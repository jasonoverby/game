module WriterStuff

  def punctuation
    %w(. ! ? ¡ ¿)
  end

  def indefinite_articlerize(word)
    %w(a e i o u).include?(word[0].downcase) ? "an #{word}" : "a #{word}"
  end

  def filler
    "#{%w(Hmmmm Well Er Um Huh Ok).sample}..."
  end

  def present_choices(array)
    puts "Choose:"
    array.each_with_index {|element,index| puts "#{index + 1}. #{element}"}
    print "> "
  end

  def choose
    $stdin.gets.chomp.to_i
  end

  def choose_minus_one
    # allows user to select array element since select choices are shifted forward by 1
    choose - 1
  end

  def get_name
    puts "Hello, there!"
    puts "What is your name?"
    print "> "
    $name = $stdin.gets.chomp
    puts "Garsh!  That is the best name!" if $name.downcase == "ruby"
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

  def choose_book
    puts "Whick of these tomes do you want to carry for spiritual guidance?"
    book_array = []
    books.each do |author, title|
      book_array << "'#{title}' by #{author}"
    end
    present_choices(book_array)
    $book = book_titles[choose_minus_one]
  end

  def die
    puts "You spiral into a depression..."
    puts "...and die :("
    exit(0)
  end

end

module Combat
  include WriterStuff

  def battle
    puts "Welcome to the battle of your life."
    @idea_hp = rand(30..60)
    puts "The idea has #{@idea_hp} hit points."
    puts "Your weapon is #{indefinite_articlerize($tool)}."
    while $hp > 0 && @idea_hp > 0
      writer_gets_hit
      $hp > 0 ? idea_gets_hit : next
    end
    if @idea_dies
      post_battle
    else
      die
    end
  end

  def post_battle
    puts "You made it out alive!"
    $work = %w(novel story poem pamphlet manual editorial).sample
    puts "You have written #{indefinite_articlerize($work)}."
    choices = %w(Go\ to\ the\ bookstore Go\ to\ the\ bathroom Fight\ again)
    present_choices(choices)
    choice = choose
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
