require 'test_helper'

class SegmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index," do
    get segments_index,_url
    assert_response :success
  end

  test "should get create," do
    get segments_create,_url
    assert_response :success
  end

  test "should get update," do
    get segments_update,_url
    assert_response :success
  end

  test "should get destroy," do
    get segments_destroy,_url
    assert_response :success
  end

  test "should get show" do
    get segments_show_url
    assert_response :success
  end

end
