require 'test_helper'

class OpportuniteesControllerTest < ActionController::TestCase
  setup do
    @opportunitee = opportunitees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:opportunitees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create opportunitee" do
    assert_difference('Opportunitee.count') do
      post :create, opportunitee: @opportunitee.attributes
    end

    assert_redirected_to opportunitee_path(assigns(:opportunitee))
  end

  test "should show opportunitee" do
    get :show, id: @opportunitee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @opportunitee
    assert_response :success
  end

  test "should update opportunitee" do
    put :update, id: @opportunitee, opportunitee: @opportunitee.attributes
    assert_redirected_to opportunitee_path(assigns(:opportunitee))
  end

  test "should destroy opportunitee" do
    assert_difference('Opportunitee.count', -1) do
      delete :destroy, id: @opportunitee
    end

    assert_redirected_to opportunitees_path
  end
end
