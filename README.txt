= SimpleMemoize

* http://github.com/JackDanger/simple_memoize/

Developed for and by the engineers at http://adPickles.com/

== DESCRIPTION:

Provides in-memory caching of any Ruby method.  It's dead simple and won't get in the way of any of your code.
For something more robust that offers persistence try http://github.com/JackDanger/cached_values/
Documentation also available here: http://objectproxy.rubyforge.org/simple_memoize/

== USAGE:

There's only one method and it's usage is completely manual.

  class Location
    def geocoding(lat, long)
      ... complicated stuff goes here ..
    end
    
    memoize :geocoding
  end
  
Now, when you try calling the geocoding method it might take a while the first time but the results of
that initial method call will be memoized (cached) into memory.  The second time you call it the
results will return instantly.

Note: there is a separate memo of the method for each combination of arguments.  So calling the
method a second time with different arguments will cause the method to execute fully.
  
  location = Location.new
  location.geocoding(45.123, 123.45) # will take a while
  location.geocoding(45.123, 123.45) # will return immediately
  location.geocoding(12.876, 76.914) # will take a while because these arguments haven't been memoized
  location.geocoding(12.876, 76.914) # will return immediately
  location.geocoding(45.123, 123.45) # will return immediately because it's still memoized from before
  
You can use this on all classes and modules.

  Module Colorizable
  
    def preferred_color
      :blue
    end
    memoize :preferred_color
  
    class << self
      def colors
        [:blue, :green]
      end
      memoize :colors
    end
  end
  
  class House
    include Colorizable
    
    def paint
      'do painting'
    end
    memoize :paint
    
    class << self
      def find_blues
        .. find blue houses..
      end
      memoize :find_blues
    end
  end
  
  # the following are all memoized:
  Colorizable.colors
  House.new.preferred_color
  House.find_blues
  House.new.paint
  
That's it.  If you need anything different I recommend forking this library and bending it to your will.

== INSTALL:

In Rails: 

  ruby script/plugin install git://github.com/JackDanger/simple_memoize.git
  
As a gem:

  sudo gem install simple_memoize

== LICENSE:

(The MIT License)

Copyright (c) 2008 Jack Danger Canty, Joel Friedman

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
