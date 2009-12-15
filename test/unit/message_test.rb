require File.dirname(__FILE__) + '/../test_helper'

class MessageTest < Test::Unit::TestCase
  fixtures :messages

  def test_validations
    blank_message = Message.new()
    assert !blank_message.valid?
    
    good_message = Message.new(:body => "hey there!", :user_name => "bob")
    assert good_message.valid?
  end
end
