require 'test_helper'

class PromotionPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @promotion_post = promotion_posts(:one)
  end

  test "should get index" do
    get promotion_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_promotion_post_url
    assert_response :success
  end

  test "should create promotion_post" do
    assert_difference('PromotionPost.count') do
      post promotion_posts_url, params: { promotion_post: { author_id: @promotion_post.author_id, description: @promotion_post.description, image: @promotion_post.image, post_url: @promotion_post.post_url, subimage1: @promotion_post.subimage1, subimage2: @promotion_post.subimage2, subimage3: @promotion_post.subimage3, utc_offset: @promotion_post.utc_offset } }
    end

    assert_redirected_to promotion_post_url(PromotionPost.last)
  end

  test "should show promotion_post" do
    get promotion_post_url(@promotion_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_promotion_post_url(@promotion_post)
    assert_response :success
  end

  test "should update promotion_post" do
    patch promotion_post_url(@promotion_post), params: { promotion_post: { author_id: @promotion_post.author_id, description: @promotion_post.description, image: @promotion_post.image, post_url: @promotion_post.post_url, subimage1: @promotion_post.subimage1, subimage2: @promotion_post.subimage2, subimage3: @promotion_post.subimage3, utc_offset: @promotion_post.utc_offset } }
    assert_redirected_to promotion_post_url(@promotion_post)
  end

  test "should destroy promotion_post" do
    assert_difference('PromotionPost.count', -1) do
      delete promotion_post_url(@promotion_post)
    end

    assert_redirected_to promotion_posts_url
  end
end
