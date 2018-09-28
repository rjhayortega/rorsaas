require 'test_helper'

class FacebookAdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @facebook_ad = facebook_ads(:one)
  end

  test "should get index" do
    get facebook_ads_url
    assert_response :success
  end

  test "should get new" do
    get new_facebook_ad_url
    assert_response :success
  end

  test "should create facebook_ad" do
    assert_difference('FacebookAd.count') do
      post facebook_ads_url, params: { facebook_ad: { facebook_connected_account_id: @facebook_ad.facebook_connected_account_id } }
    end

    assert_redirected_to facebook_ad_url(FacebookAd.last)
  end

  test "should show facebook_ad" do
    get facebook_ad_url(@facebook_ad)
    assert_response :success
  end

  test "should get edit" do
    get edit_facebook_ad_url(@facebook_ad)
    assert_response :success
  end

  test "should update facebook_ad" do
    patch facebook_ad_url(@facebook_ad), params: { facebook_ad: { facebook_connected_account_id: @facebook_ad.facebook_connected_account_id } }
    assert_redirected_to facebook_ad_url(@facebook_ad)
  end

  test "should destroy facebook_ad" do
    assert_difference('FacebookAd.count', -1) do
      delete facebook_ad_url(@facebook_ad)
    end

    assert_redirected_to facebook_ads_url
  end
end
