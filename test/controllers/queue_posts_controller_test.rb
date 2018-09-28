require 'test_helper'

class QueuePostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @queue_list = queue_lists(:one)
    @queue_post = queue_posts(:one)
  end

  # test "should get index" do
  #   get queue_posts_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_queue_post_url
  #   assert_response :success
  # end

  test "should create queue_post" do
    assert_difference('QueuePost.count') do
      post queue_list_queue_posts_url(@queue_list), params: { queue_post: { description: @queue_post.description, image: @queue_post.image, post_url: @queue_post.post_url, queue_list_id: @queue_post.queue_list_id, queue_post: @queue_post.queue_post, subimage1: @queue_post.subimage1, subimage2: @queue_post.subimage2, subimage3: @queue_post.subimage3, utc_offset: @queue_post.utc_offset } }
    end

    assert_redirected_to queue_list_url(QueuePost.last.queue_list)
  end

  # test "should show queue_post" do
  #   get queue_post_url(@queue_post)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_queue_post_url(@queue_post)
  #   assert_response :success
  # end

  # test "should update queue_post" do
  #   patch queue_post_url(@queue_post), params: { queue_post: { description: @queue_post.description, image: @queue_post.image, post_url: @queue_post.post_url, queue_list_id: @queue_post.queue_list_id, queue_post: @queue_post.queue_post, subimage1: @queue_post.subimage1, subimage2: @queue_post.subimage2, subimage3: @queue_post.subimage3, utc_offset: @queue_post.utc_offset } }
  #   assert_redirected_to queue_post_url(@queue_post)
  # end

  # test "should destroy queue_post" do
  #   assert_difference('QueuePost.count', -1) do
  #     delete queue_post_url(@queue_post)
  #   end

  #   assert_redirected_to queue_posts_url
  # end
end
