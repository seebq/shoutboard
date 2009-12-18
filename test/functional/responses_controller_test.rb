require 'test_helper'

class ResponsesControllerTest < ActionController::TestCase
  test "index returns xml only" do
    parent = messages(:message_with_children)
    get :index, :format => "xml", :message_id => parent.to_param
    assert_response :success
  end
  
end
