require 'test_helper'

class PropertyImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @property_image = property_images(:one)
  end

  test "should get index" do
    get property_images_url
    assert_response :success
  end

  test "should get new" do
    get new_property_image_url
    assert_response :success
  end

  test "should create property_image" do
    assert_difference('PropertyImage.count') do
      post property_images_url, params: { property_image: { file: @property_image.file, property_id: @property_image.property_id } }
    end

    assert_redirected_to property_image_url(PropertyImage.last)
  end

  test "should show property_image" do
    get property_image_url(@property_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_property_image_url(@property_image)
    assert_response :success
  end

  test "should update property_image" do
    patch property_image_url(@property_image), params: { property_image: { file: @property_image.file, property_id: @property_image.property_id } }
    assert_redirected_to property_image_url(@property_image)
  end

  test "should destroy property_image" do
    assert_difference('PropertyImage.count', -1) do
      delete property_image_url(@property_image)
    end

    assert_redirected_to property_images_url
  end
end
