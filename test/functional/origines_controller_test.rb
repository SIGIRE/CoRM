require 'test_helper'

class OriginesControllerTest < ActionController::TestCase
  setup do
    @origine = origines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:origines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create origine" do
    assert_difference('Origine.count') do
      post :create, origine: @origine.attributes
    end

    assert_redirected_to origine_path(assigns(:origine))
  end

  test "should show origine" do
    get :show, id: @origine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @origine
    assert_response :success
  end

  test "should update origine" do
    put :update, id: @origine, origine: @origine.attributes
    assert_redirected_to origine_path(assigns(:origine))
  end

  test "should destroy origine" do
    assert_difference('Origine.count', -1) do
      delete :destroy, id: @origine
    end

    assert_redirected_to origines_path
  end
end
