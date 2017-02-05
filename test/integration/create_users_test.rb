require 'test_helper'

class CreateUsersTest < ActionDispatch::IntegrationTest
  
  test "get new user form and create user" do
    get signup_path
    assert_template 'users/new'
    
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user:{username: "Test", email: "email@email.com", password: "pass", admin: false}
    
    end
    
    assert_template 'users/show'
    assert_match "Test", response.body
  end
  
    
  test "invalid user email submission results in failure" do
    get signup_path
    assert_template 'users/new'
    
    assert_no_difference 'User.count' do
      post users_path, user: {username: "123", email: "email..", password: "pass", admin: false}
    end
  
    assert_template 'users/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end