# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  def setup
    @stack = Stack.new(%w[one two three])
  end

  def test_initialize
    stack = Stack.new

    assert { stack.empty? }
    assert { stack.to_a == [] }
  end

  def test_push
    @stack.push!('four')

    assert { @stack.to_a.last == 'four' }
    assert { @stack.to_a.length == 4 }
  end

  def test_pop
    @stack.pop!

    assert { @stack.to_a.last == 'two' }
    assert { @stack.to_a.length == 2 }
  end

  def test_clear
    @stack.clear!

    assert { @stack.to_a == [] }
    assert { @stack.empty? }
  end
end
