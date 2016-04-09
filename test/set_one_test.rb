require_relative '../lib/set_one'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class SetOneTest < MiniTest::Test

  def setup
    @robots = [["bender", :good], ["fender", :bad], ["hender", :questionable],
               ["wender", :good], ["dender", :good], ["mender", :bad]]
  end

  def test_that_set_one_contains_the_class_robots
    robots = Robots.new.class
    assert_equal Robots, robots
  end

  def test_that_the_class_robots_can_take_an_argument
    robots = Robots.new("fender")
    assert_equal "fender", robots.robots
  end

  def test_find_bad_robots_and_their_behavior_returns_all_bad_robots
    robots = Robots.new(@robots)
    robots = robots.find_bad_robots_and_their_behavior

    assert_equal [["fender", :bad], ["mender", :bad]], robots
  end

  def test_find_names_of_good_robots_returns_all_good_robots
    robots = Robots.new(@robots)
    robots = robots.find_names_of_good_robots

    assert_equal ["bender", "wender", "dender"], robots
  end

  def test_find_first_robot_that_is_bad
    robots = Robots.new(@robots)

    assert_equal "fender", robots.find_bad_robots_name
  end

  def test_find_last_bad_robots_name
    robots = Robots.new(@robots)

    assert_equal "mender", robots.find_last_bad_robots_name
  end

  def test_questionable_behavior_gets_changed_to_nil
    robots = Robots.new(@robots)
    answer = [["bender", :good], ["fender", :bad], nil,
              ["wender", :good], ["dender", :good], ["mender", :bad]]

    assert_equal answer, robots.change_questionable_robots_to_nil
  end

  def test_return_string_of_robots_and_their_behaviors_returns_one_string
    robots = Robots.new(@robots[0..2])
    answer = "I'm bender and I'm good, I'm fender and I'm bad, I'm hender and I'm questionable"

    assert_equal answer, robots.create_string_of_robots_and_their_behaviors
  end

end
