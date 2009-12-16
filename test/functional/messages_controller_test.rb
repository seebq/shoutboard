require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  test "should load main index page" do
    get :index
    assert_response :success
  end
  
  test "should create message shout without ajax" do
    assert_difference('Message.count') do
      post :create, :message => {:user_name => 'casey', :body => 'that that is is that that is not is not is that that is' }
    end

    assert_redirected_to messages_path
  end
  
  test "should create message via ajax request" do
    assert_difference('Message.count') do
      xhr :post, :create, :message => {:user_name => 'casey', :body => 'that that is is that that is not is not is that that is' }
    end
    # make sure we set a new message object #
    assert_not_nil assigns(:new_message) 
    assert_response :success 
  end
  
  test "should update dom after create message via ajax request" do
    xhr :post, :create, :message => {:user_name => 'casey', :body => 'that that is is that that is not is not is that that is' }
    assert_select_rjs :insert, :top, "messages_list"
  end

  
end
