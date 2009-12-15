require File.dirname(__FILE__) + '/../test_helper'
require 'messages_controller'

# Re-raise errors caught by the controller.
class MessagesController; def rescue_action(e) raise e end; end

class MessagesControllerTest < Test::Unit::TestCase
  def setup
    @controller = MessagesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_the_wall
    get :wall
    assert_response :success
    assert assigns(:messages)
  end

  def test_the_history
    get :history
    assert_response :success
    assert assigns(:messages)
  end


  def test_post_message
    num_shouts = Message.count # 0
    
    # failure - no body
    post :shout, :message => {:body => ""}
    assert_equal num_shouts, Message.count
    
    # success
    post :shout, :message => {:body => "Hey everybody, check this out!", :user_name => 'Bob'}

    assert_equal num_shouts + 1, Message.count
    assert_redirected_to '/messages/wall'
  end
  
end
