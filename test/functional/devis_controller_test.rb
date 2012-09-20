require 'test_helper'

class DevisControllerTest < ActionController::TestCase
  setup do
    @devi = devis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:devis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create devi" do
    assert_difference('Devi.count') do
      post :create, devi: {  }
    end

    assert_redirected_to devi_path(assigns(:devi))
  end

  test "should show devi" do
    get :show, id: @devi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @devi
    assert_response :success
  end

  test "should update devi" do
    put :update, id: @devi, devi: {  }
    assert_redirected_to devi_path(assigns(:devi))
  end

  test "should destroy devi" do
    assert_difference('Devi.count', -1) do
      delete :destroy, id: @devi
    end

    assert_redirected_to devis_path
  end
end
