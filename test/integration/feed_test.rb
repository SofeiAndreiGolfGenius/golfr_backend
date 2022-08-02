require 'test_helper'

# We check if the feed returns 25 scores maximum
class UsersIndexTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # we include this to use the sign_in method
  setup do
    @user = users(:george)
  end

  test 'scores limited to 25' do
    sign_in @user

    get api_feed_url, as: :json
    assert_response :success

    response_feed = JSON.parse(response.body)
    assert response_feed['scores'].count <= 25
  end
end
