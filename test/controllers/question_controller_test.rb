require 'test_helper'

class QuestionControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get question_create_url
    assert_response :success
  end

end
