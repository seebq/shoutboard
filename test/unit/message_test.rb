require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  fixtures :messages

  def test_validations
    blank_message = Message.new()
    assert !blank_message.valid?
    
    good_message = Message.new(:body => "hey there!", :user_name => "bob")
    assert good_message.valid?
  end
  
  test "should respond to message types" do
    assert Message.respond_to?(:message_types)
  end
  
  test "message types should return a hash of message types" do
    assert Message.message_types.is_a?(Hash)
  end
  
  test "message type should accept only certain values " do
    message = Message.new(:body => 'test')
    message.message_type = 738 #invalid
    assert !message.valid?
  end
  
  test "message type should allow certain values" do
    message = Message.new(:body => 'test')
    message.message_type = 0 #valid
    assert message.valid?
     
    message = Message.new(:body => 'test')
    message.message_type = "0" #valid
    assert message.valid?
  end
  
end
