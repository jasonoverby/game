$LOAD_PATH << '.'
require "game_module"

class Test
  include Greet

  def initialize
    # variable must be included in initialize or def for
    # object to have access to it
    # & must be an instance variable
    @punctuation = %w(. ! ?)
  end

  def greeting(name)
    # but non-instance variable can be used w/in scope
    hello = "HELLLLLLOOOOOOO"


    puts "#{test_greeting}, #{name}#{@punctuation[rand(0..@punctuation.length - 1)]}"
    # TRY WITH %s
    # puts format("%s, %s%s", test_greeting, name, @punctuation[rand(0..@punctuation.length - 1)])
    # puts sprintf("%s, %s%s", test_greeting, name, @punctuation[rand(0..@punctuation.length - 1)])
    # puts "%s, %s%s" % [test_greeting, name, @punctuation[rand(0..@punctuation.length - 1)]]
    puts hello
  end
end

class Room
  def hello
    puts "Hello, Virld!"
  end
end

class Cafe < Room
end

class Study < Room
end

class Library < Room
end

t = Test.new
t.greeting("Jason")

r = Cafe.new
r.hello
