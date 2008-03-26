require 'test/unit'
require File.dirname(__FILE__) + '/../lib/simple_memoize'
require 'rubygems'
require 'mocha'

module Barks
  def growl
    'Grrrrr'
  end
  memoize :growl
  
  def protected_growl
    'Grrrrr'
  end
  protected :protected_growl
  memoize   :protected_growl
  
  def private_growl
    'Grrrrr'
  end
  private :private_growl
  memoize :private_growl
  
  class << self
    def sounds
      ['woof', 'ruff']
    end
    memoize :sounds
  end
end

class Dog
  include Barks
  
  def drink
    'slurp'
  end
  memoize :drink
  
  class << self
    def breeds
      ['doberman', 'dalmatian']
    end
    memoize :breeds
  end
end

class SimpleMemoizeTest < Test::Unit::TestCase
  def test_module_method_only_calls_memoized_once
    dog = Dog.new
    dog.expects(:growl_without_memo).returns('Grrrrr').once
    4.times { dog.growl }
  end

  def test_module_method_calls_method_several_times
    dog = Dog.new
    dog.expects(:growl).returns('Grrrrr').times(4)
    4.times { dog.growl }
  end

  def test_module_class_method_only_calls_memoized_once
    sounds = Barks.sounds_without_memo
    Barks.expects(:sounds_without_memo).returns(sounds).once
    4.times { Barks.sounds }
  end

  def test_module_class_method_calls_method_several_times
    sounds = Barks.sounds_without_memo
    Barks.expects(:sounds).returns(sounds).times(4)
    4.times { Barks.sounds }
  end
  
  def test_object_method_calls_memoized_once
    dog = Dog.new
    drink = dog.drink_without_memo
    dog.expects(:drink_without_memo).returns(drink).once
    4.times { dog.drink }
  end
  
  def test_object_method_calls_method_several_times
    dog = Dog.new
    drink = dog.drink_without_memo
    dog.expects(:drink).returns(drink).times(4)
    4.times { dog.drink }
  end
  
  def test_class_method_calls_memoized_once
    breeds = Dog.breeds_without_memo
    Dog.expects(:breeds_without_memo).returns(breeds).once
    4.times { Dog.breeds }
  end
  
  def test_class_method_calls_method_several_times
    breeds = Dog.breeds_without_memo
    Dog.expects(:breeds).returns(breeds).times(4)
    4.times { Dog.breeds }
  end
  
  def test_protected_methods_remain_protected
    dog = Dog.new
    assert dog.protected_methods.include?('protected_growl_without_memo')
    assert dog.protected_methods.include?('protected_growl')
  end
  
  def test_private_methods_remain_private
    dog = Dog.new
    assert dog.private_methods.include?('private_growl_without_memo')
    assert dog.private_methods.include?('private_growl')
  end
end
