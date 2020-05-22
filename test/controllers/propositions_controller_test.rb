require 'test_helper'

class PropositionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get propositions_index_url
    assert_response :success
  end

  test "should get new" do
    get propositions_new_url
    assert_response :success
  end

  test "should get edit" do
    get propositions_edit_url
    assert_response :success
  end

  test "should get show" do
    get propositions_show_url
    assert_response :success
  end

  test "should get mypage_index" do
    get propositions_mypage_index_url
    assert_response :success
  end

  test "should get offer" do
    get propositions_offer_url
    assert_response :success
  end

  test "should get search" do
    get propositions_search_url
    assert_response :success
  end

  test "should get finish" do
    get propositions_finish_url
    assert_response :success
  end

  test "should get match" do
    get propositions_match_url
    assert_response :success
  end
end
