require 'test_helper'

class ModelesControllerTest < ActionController::TestCase
  setup do
    @modele = modeles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:modeles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create modele" do
    assert_difference('Modele.count') do
      post :create, modele: {  }
    end

    assert_redirected_to modele_path(assigns(:modele))
  end

  test "should show modele" do
    get :show, id: @modele
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @modele
    assert_response :success
  end

  test "should update modele" do
    put :update, id: @modele, modele: {  }
    assert_redirected_to modele_path(assigns(:modele))
  end

  test "should destroy modele" do
    assert_difference('Modele.count', -1) do
      delete :destroy, id: @modele
    end

    assert_redirected_to modeles_path
  end
end
