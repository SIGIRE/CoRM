require 'test_helper'

class MailEventsControllerTest < ActionController::TestCase
  setup do
    @mail_event = mail_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mail_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mail_event" do
    assert_difference('MailEvent.count') do
      post :create, mail_event: { name: @mail_event.name, pattern: @mail_event.pattern }
    end

    assert_redirected_to mail_event_path(assigns(:mail_event))
  end

  test "should show mail_event" do
    get :show, id: @mail_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mail_event
    assert_response :success
  end

  test "should update mail_event" do
    put :update, id: @mail_event, mail_event: { name: @mail_event.name, pattern: @mail_event.pattern }
    assert_redirected_to mail_event_path(assigns(:mail_event))
  end

  test "should destroy mail_event" do
    assert_difference('MailEvent.count', -1) do
      delete :destroy, id: @mail_event
    end

    assert_redirected_to mail_events_path
  end
end
