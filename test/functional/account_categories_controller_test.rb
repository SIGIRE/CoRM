require 'test_helper'

class AccountCategoriesControllerTest < ActionController::TestCase
  setup do
    @account_category = account_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:account_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account_category" do
    assert_difference('AccountCategory.count') do
      post :create, account_category: { name: @account_category.name }
    end

    assert_redirected_to account_category_path(assigns(:account_category))
  end

  test "should show account_category" do
    get :show, id: @account_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account_category
    assert_response :success
  end

  test "should update account_category" do
    put :update, id: @account_category, account_category: { name: @account_category.name }
    assert_redirected_to account_category_path(assigns(:account_category))
  end

  test "should destroy account_category" do
    assert_difference('AccountCategory.count', -1) do
      delete :destroy, id: @account_category
    end

    assert_redirected_to account_categories_path
  end
end
