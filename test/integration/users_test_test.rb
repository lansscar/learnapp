require 'test_helper'

class UsersTestTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
	@user = users(:lansscar)
	@user1 = users(:lanssca)
  end
  test "unsucessful edit" do
	log_in_as(@user)
	get edit_user_path(@user)
	
	assert_template 'users/edit'
	patch user_path(@user), params: { user: { name: "",
						  email: "xi@dsds",
						  password: "fss",
						  password_confirmation: "ssf" } }
  end
  test "successful edit with a friendly redirction" do
	get edit_user_path(@user)	
	log_in_as(@user)
	
 	assert_redirected_to edit_user_url(@user)
	name = "racssnal"
	email = "lansscar@ex.com"
	patch user_path(@user), params: { user: { name: name,
						  email: email,
						  password: "",
			                          password_confirmation: "" } }
	assert_not flash.empty?
	assert_redirected_to @user
	@user.reload
	assert_equal name, @user.name
	assert_equal email, @user.email
  
  end
  test "login with remembering" do
	log_in_as(@user, remember_me: '1')
	assert_not_empty cookies['remember_token']
  end
  test "login without remembering" do
  	log_in_as(@user, remember_me: '1')
	delete logout_path
	log_in_as(@user, remember_me: '0')
	assert_empty cookies['remember_token']
  end
  test "should redirect edit when not logged in" do 
	get edit_user_path(@user)
	assert_not flash.empty?
	assert_redirected_to login_url
  end
  test "should redirect update when not logged in" do
	patch user_path(@user), params: { user: { name: @user.name,
						  email: @user.email } }
	assert_not flash.empty?
	assert_redirected_to login_url
  end
  test "should redirect edit when logged in as wrong user" do
	log_in_as(@user1)
	get edit_user_path(@user)
	assert flash.empty?
	assert_redirected_to root_url
  end
  test "should redirected update when logged in as wrong user" do
	log_in_as(@user1)
	patch user_path(@user), params: { user: { name: @user.name,
						  email: @user.email } }
	assert flash.empty?
	assert_redirected_to root_url
  end

end
