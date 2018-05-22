require 'test_helper'

class RoisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @roi = rois(:one)
  end

  test "should get index" do
    get rois_url
    assert_response :success
  end

  test "should get new" do
    get new_roi_url
    assert_response :success
  end

  test "should create roi" do
    assert_difference('Roi.count') do
      post rois_url, params: { roi: {  } }
    end

    assert_redirected_to roi_url(Roi.last)
  end

  test "should show roi" do
    get roi_url(@roi)
    assert_response :success
  end

  test "should get edit" do
    get edit_roi_url(@roi)
    assert_response :success
  end

  test "should update roi" do
    patch roi_url(@roi), params: { roi: {  } }
    assert_redirected_to roi_url(@roi)
  end

  test "should destroy roi" do
    assert_difference('Roi.count', -1) do
      delete roi_url(@roi)
    end

    assert_redirected_to rois_url
  end
end
