require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    bob = users(:one)
    post :create, name: bob.name, password: 'secret'
    assert_redirected_to welcome_url
    assert_equal bob.id, session[:user_id]
  end

  test "should fail login" do
    bob = users(:one)
    post :create, name: bob.name, password: 'wrong'
    assert_redirected_to login_url
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to login_url
  end

end
