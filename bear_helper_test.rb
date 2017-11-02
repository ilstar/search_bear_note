require 'minitest/autorun'
require './bear_helper'

class TestBearHelper < MiniTest::Unit::TestCase
  def test_get_top_10
    # p BearHelper::ScriptFilter.new('').send :get_top_10
  end

  def test_perform_when_query_is_empty_string
    filter = BearHelper::ScriptFilter.new("")
    filter.stub(:history_content, "pizza\nbamboo") do
      assert filter.perform == %{<xml><items><item arg="pizza"><title>pizza</title></item><item arg="bamboo"><title>bamboo</title></item></items></xml>}
    end
  end

  def test_perform_when_keyword_is_same_as_history
    # only show on 'bamboo' instead of two
    filter = BearHelper::ScriptFilter.new("bamboo")
    filter.stub(:history_content, "pizza\nbamboo") do
      assert filter.perform == %{<xml><items><item arg="bamboo"><title>bamboo</title></item></items></xml>}
    end
  end

  def test_perform_when_query_has_something
    filter = BearHelper::ScriptFilter.new("bam")
    filter.stub(:history_content, "pizza\nbamboo") do
      assert filter.perform == %{<xml><items><item arg="bam"><title>bam</title></item><item arg="bamboo"><title>bamboo</title></item></items></xml>}
    end
  end

  def test_callback_url_generator
    assert BearHelper::CallbackUrlGenerator.new('abc').perform == "bear://x-callback-url/search?term=abc"
    assert BearHelper::CallbackUrlGenerator.new('#abc').perform == "bear://x-callback-url/search?tag=abc"
  end
end
