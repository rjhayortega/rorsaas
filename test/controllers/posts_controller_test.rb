require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  # test "should get index" do
  #   get posts_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_post_url
  #   assert_response :success
  # end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url(format: :json), params: {
        post: {
          image: "https://knackmap-dev.s3.amazonaws.com/uploads/medium/file/26/Screen_Shot_2017-05-05_at_10.49.56.png",
          content: "vjwoiefiojiqpwef",
          accounts: ["8303", "8302"],
        },
        token: 'CPxB8S5LuGMjRfomrs9Z'
      }
    end
    # assert_redirected_to post_url(Post.last)
  end

  # test "should show post" do
  #   get post_url(@post)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_post_url(@post)
  #   assert_response :success
  # end

  # test "should update post" do
  #   patch post_url(@post), params: { post: {  } }
  #   assert_redirected_to post_url(@post)
  # end

  # test "should destroy post" do
  #   assert_difference('Post.count', -1) do
  #     delete post_url(@post)
  #   end

  #   assert_redirected_to posts_url
  # end
end
