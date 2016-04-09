# Ruby Enumerables Practice

### Setup

from the command line navigate your way into your practice directory if you have one:

```ruby
$ cd ~/practice_directory
```

if you don't have one create one where you would like it to be:

```ruby
$ mkdir practice_directory
```

from the command line clone this repository down:

```ruby
$ git clone https://github.com/thompickett/enums_pracitce.git
```

There are two sets in the lib directory. They both have different scenarios in which you'll have to decide which enumerable is appropriate to use. Set two is intended to be slightly harder, so take a look at them and decide which you'd like to try first. There is a [hints](https://github.com/thompickett/enums_pracitce/blob/master/hints.markdown) file you can look at, but first try going to [ruby-docs](http://ruby-doc.org/core-2.3.0/Enumerable.html) to figure it out.  

Go ahead and peek in the Gemfile, it contains the tools we'll be using for this exercise. Whenever you have a Gemfile you need to bundle the gems for use. From the command line go ahead and hit:

```ruby
$ bundle
```

We're going to be using Minitest to test out our code. If you aren't familiar, after your code is filled in, you'll type:

```ruby
$ ruby file_name_of_test.rb
```

### Areas of Focus

##### Main Focuses
* Figuring out which is the appropriate enumerable to use
* Use pry to debug and dig into how the enum is working and where you are in the stack

##### Secondary Focuses
* How to implement the desired enumerable
* Finding resources to find the answer


### How to

lets do the first one together. You're asked to make this test pass:

``` ruby
def test_find_bad_robots_and_their_behavior_returns_all_bad_robots
  robots = Robots.new(@robots)
  robots = robots.find_bad_robots_and_their_behavior

  assert_equal [["fender", :bad], ["mender", :bad]], robots
end
```

with this passed in as robots:
``` ruby
@robots = [["bender", :good], ["fender", :bad], ["hender", :questionable], ["wender", :good], ["dender", :good], ["mender", :bad]]
```

So first lets try and figure out what our goal is. We have an array and we're trying to return a couple of nested arrays containing a robot, and their behavior. That tell me we could use an enumerable to search for the desired data.

lets look at the ruby-docs to try and figure out which one?  
[ruby-docs](http://ruby-doc.org/core-2.3.0/Enumerable.html)  

Sorting through them we see that there's one called select which has an alias find_all. It goes through each element in an array, and if it finds one that is correct select, passes the element into an array, and then returns the array.
looks like a winner.

We have an instance variable setup already containing the robot collection in our set_one.rb file.

```ruby
robots.select do |robot|

end
```

Now lets throw a pry in there and see what's going on
``` ruby
robots.select do |robot|
  binding.pry
end
```

run the test from the command line
``` ruby
$ ruby test/set_one_test.rb
```

We should see something like this:
``` ruby
    9: def find_bad_robots_and_their_behavior
   10:   robots.select do |robot|
=> 11:     binding.pry
   12:   end
   13: end
```

the symbol "=>" represents where we are in the stack trace at that moment. Now from the command line we can see what is our program is doing.

enter self into the command line:

``` ruby
$ self
```

it should return something like this:

``` ruby
=> #<Robots:0x007f85f42c5048
 @robots=
  [["bender", :good],
   ["fender", :bad],
   ["hender", :questionable],
   ["wender", :good],
   ["dender", :good],
   ["mender", :bad]]>
```

lets break it down

``` ruby
=> #<Robots:0x007f85f42c5048
```

This represents our object that is self. In this case self is the class Robots that we are currently in.

``` ruby
@robots=
```

This is the method 'robots' contained within self.

``` ruby
[["bender", :good],
   ["fender", :bad],
   ["hender", :questionable],
   ["wender", :good],
   ["dender", :good],
   ["mender", :bad]]>
```

This is the nested array that robots is equal to.

Now from the command line we can type in:

``` ruby
robot
```

This is the individual element of robot, and will return:

``` ruby
["bender", :good]
```

This is what the current element of robot returns. Now from the command line type:

``` ruby
$ next
```

This command comes from the gem pry-nav it will move to the next spot in the stack trace. Now if we type in robots will see the return:

``` ruby
=> ["fender", :bad]
```

Try that process again.

Now that we see what information is available from within the enumerable method we can figure out what we need to do next.

We know were looking the value :bad, and we know that each element of robot contains an array with the zero index equal to the robot's name, and the first or in this case also the last index's position. So using ruby's array method .last we can find the elements we want.

``` ruby
def find_bad_robots_and_their_behavior
  robots.select do |robot|
    robot.last == :bad
  end
end
```

now if we exit from the the pry session, we can run it again with that new line of code inserted and see if the test passes

``` ruby
$ exit!
$ ruby test/set_one_test.rb
```
If you want to see more of how pry works try using it again in the the enumerable method block and type in

``` ruby
$ robot
$ exit
$ robot
$ next
$ next
$ exit!
```

Did you figure out all the differences in those different commands?

Cool, now it time to do make the rest of those tests pass.
