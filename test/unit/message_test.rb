require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  fixtures :messages

  def test_validations
    blank_message = Message.new()
    assert !blank_message.valid?
    
    good_message = Message.new(:body => "hey there!", :user_name => "bob", :message_type => Message.default_message_type)
    assert good_message.valid?
  end
  
  test "cannot save a message with a parent of a message that is already a child" do
    response_message = messages(:child_message)
    new_message = Message.new(:body => 'hey', :user_name => 'anonymous', :message_type => Message.default_message_type, :parent_id => response_message.id)
    assert !new_message.valid?
  end
  
  test "can save a message as a response to an existing message" do
    parent_message = messages(:message_without_children)
    new_message = Message.new(:body => 'hey', :user_name => 'anonymous', :message_type => Message.default_message_type, :parent_id => parent_message.id)
    assert new_message.valid?
  end
  
  test "should respond to message types" do
    assert Message.respond_to?(:message_types)
  end
  
  test "message types should return an array of message types" do
    assert Message.message_types.is_a?(Array)
  end
  
  test "message type should accept only certain values " do
    message = Message.new(:body => 'test')
    message.message_type = 738 #invalid
    assert !message.valid?
  end
  
  test "message type should allow certain values" do
    message = Message.new(:body => 'test')
    message.message_type = 'codes' #valid
    assert message.valid?
     
    message = Message.new(:body => 'test')
    message.message_type = 'says' #valid
    assert message.valid?
  end

  
end
