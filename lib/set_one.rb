
class Robots
  attr_reader :robots

  def initialize(robots = nil)
    @robots = robots
  end

  def find_bad_robots_and_their_behavior

    robots.select do |robot|
      robot.last == :bad
    end
  end

  def find_names_of_good_robots
    # robots.select { |bot| bot.last == :good }.map { |bot| bot.first} 
    robots.map { |bot| bot.first if bot.last == :good }.compact
  end

  def find_bad_robots_name
    # use #find to find the first occurance only
    # binding.pry
    robots.find { |robot| robot.last == :bad }.first

    # robots.find { |robot| robot.last == :bad }.first
    # => ["fender", :bad]
    # new_array.first
  end

  def find_last_bad_robots_name

    # robots.select do |robot|
    # robot.last == :bad
    # end.last.first
    robots.select { |robot| robot.last == :bad }.last.first

  end

  def change_questionable_robots_to_nil
    robots.map do |bot|
      if bot.last == :questionable
       nil
      else
        bot
      end 
    end
  end

  def create_string_of_robots_and_their_behaviors
    robots.map { |bot| "I'm #{bot.first} and I'm #{bot.last}" }.join(", ")
  end
end

