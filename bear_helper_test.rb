require 'minitest/autorun'
require './bear_helper'

class TestBearHelper < MiniTest::Unit::TestCase
  def test_get_top_10
    # p BearHelper::ScriptFilter.new('').send :get_top_10
  end

  def test_perform
    puts BearHelper::ScriptFilter.new('insta').perform
  end
end
