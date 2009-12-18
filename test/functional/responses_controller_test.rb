require 'test_helper'

class ResponsesControllerTest < ActionController::TestCase
  test "index returns xml only" do
    parent = messages(:message_with_children)
    get :index, :format => "xml", :message_id => parent.to_param
    assert_response :success
  end
  
  test "new page renders in html" do
    get :new, :message_id => messages(:anonymous_message).to_param
    assert_response :success
  end
  
  test "submitting a new response saves correctly" do
    assert_difference "Message.count" do 
      xhr :post, :create, :message_id => messages(:anonymous_message).to_param, 
                    :message => {:body => 'responsified', 
                                 :message_type => Message.default_message_type,
                                 :parent_id => messages(:anonymous_message).to_param
                                 }
    end
    
    assert_not_nil assigns(:new_message) # it should create a new, empty object for the form
    assert_not_nil assigns(:message) # and obviously provide the newly-created object to render
  end
  
  test "submitting a new response updates the DOM with new message" do
    assert_difference "Message.count" do 
      xhr :post, :create, :message_id => messages(:anonymous_message).to_param, 
                    :message => {:body => 'responsified', 
                                 :message_type => Message.default_message_type,
                                 :parent_id => messages(:anonymous_message).to_param
                                 }
    end
    
    # should insert at the bottom of the list of responses
    assert_select_rjs :insert, :bottom, "response_messages_list_to_shout_#{messages(:anonymous_message).to_param}"
    
    # ...and re-render the shout-create form
    assert_select_rjs :replace_html, 'shout_form'
  end
  
  
  
end
