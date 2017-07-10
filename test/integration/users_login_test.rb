require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
	@user = users(:lansscar)
  end
  test "login with invalid info or log out?" do
	get login_path
	assert_template 'sessions/new'
	post login_path, params: { session: { email: @user.email, password: "password" } }
	assert_redirected_to @user
	follow_redirect!
	assert_template 'users/show'
	assert_select "a[href=?]", login_path, count: 0
	assert_select "a[href=?]", logout_path
	assert_select "a[href=?]", user_path(@user)
	assert is_logined_in?
	delete logout_path

	assert_not is_logined_in?
	assert_redirected_to root_url

	delete logout_path
	follow_redirect!
	assert_select "a[href=?]", login_path
	assert_select "a[href=?]", logout_path, count: 0
	assert_select "a[href=?]", user_path(@user), count: 0
   end

	
end
