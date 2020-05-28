require 'test_helper'

class AchievementsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get achievements_new_url
    assert_response :success
  end

  test "should get edit" do
    get achievements_edit_url
    assert_response :success
  end
end
