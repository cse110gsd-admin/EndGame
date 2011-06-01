require 'test_helper'

class WarmupsControllerTest < ActionController::TestCase
  setup do
    @warmup = warmups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:warmups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create warmup" do
    assert_difference('Warmup.count') do
      post :create, :warmup => @warmup.attributes
    end

    assert_redirected_to warmup_path(assigns(:warmup))
  end

  test "should show warmup" do
    get :show, :id => @warmup.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @warmup.to_param
    assert_response :success
  end

  test "should update warmup" do
    put :update, :id => @warmup.to_param, :warmup => @warmup.attributes
    assert_redirected_to warmup_path(assigns(:warmup))
  end

  test "should destroy warmup" do
    assert_difference('Warmup.count', -1) do
      delete :destroy, :id => @warmup.to_param
    end

    assert_redirected_to warmups_path
  end
end
