require 'test_helper'

class QueueListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @queue_list = queue_lists(:one)
  end

  # test "should get index" do
  #   get queue_lists_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_queue_list_url
  #   assert_response :success
  # end

  test "should create queue_list" do
    assert_difference('QueueList.count') do
      post queue_lists_url, params: { queue_list: { activity: @queue_list.activity, image: @queue_list.image, name: @queue_list.name, started_on: @queue_list.started_on, user_id: @queue_list.user_id } }
    end

    assert_redirected_to activity_queue_list_url(QueueList.last, creating: true)
  end

  # test "should show queue_list" do
  #   get queue_list_url(@queue_list)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_queue_list_url(@queue_list)
  #   assert_response :success
  # end

  # test "should update queue_list" do
  #   patch queue_list_url(@queue_list), params: { queue_list: { activity: @queue_list.activity, image: @queue_list.image, name: @queue_list.name, started_on: @queue_list.started_on, user_id: @queue_list.user_id } }
  #   assert_redirected_to queue_list_url(@queue_list)
  # end

  # test "should destroy queue_list" do
  #   assert_difference('QueueList.count', -1) do
  #     delete queue_list_url(@queue_list)
  #   end

  #   assert_redirected_to queue_lists_url
  # end
end
