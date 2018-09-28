require 'test_helper'

class FacebookConnectedAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @facebook_connected_account = facebook_connected_accounts(:one)
  end

  test "should get index" do
    get facebook_connected_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_facebook_connected_account_url
    assert_response :success
  end

  test "should create facebook_connected_account" do
    assert_difference('FacebookConnectedAccount.count') do
      post facebook_connected_accounts_url, params: { facebook_connected_account: { facebook_ad_account_id: @facebook_connected_account.facebook_ad_account_id, profile_page_id: @facebook_connected_account.profile_page_id, user_id: @facebook_connected_account.user_id, verified: @facebook_connected_account.verified } }
    end

    assert_redirected_to facebook_connected_account_url(FacebookConnectedAccount.last)
  end

  test "should show facebook_connected_account" do
    get facebook_connected_account_url(@facebook_connected_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_facebook_connected_account_url(@facebook_connected_account)
    assert_response :success
  end

  test "should update facebook_connected_account" do
    patch facebook_connected_account_url(@facebook_connected_account), params: { facebook_connected_account: { facebook_ad_account_id: @facebook_connected_account.facebook_ad_account_id, profile_page_id: @facebook_connected_account.profile_page_id, user_id: @facebook_connected_account.user_id, verified: @facebook_connected_account.verified } }
    assert_redirected_to facebook_connected_account_url(@facebook_connected_account)
  end

  test "should destroy facebook_connected_account" do
    assert_difference('FacebookConnectedAccount.count', -1) do
      delete facebook_connected_account_url(@facebook_connected_account)
    end

    assert_redirected_to facebook_connected_accounts_url
  end
end
