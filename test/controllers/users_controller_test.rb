require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
	@user = users(:lansscar)
	@user1 = users(:lanssca)
  end
  test "should get new" do
    get signup_path
    assert_response :success
  end
  test "should redirect index when not logged in" do
	get users_path
	assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be changed via the web" do
	log_in_as(@user1)
	assert_not @user1.admin?
	patch user_path(@user1), params: { user: { password: '',
						  password_confirmation: '',
						  admin: true
 } }
	assert_not @user1.admin?
  end
  test "should destroy user when ont logged in" do
	assert_no_difference 'User.count' do
		delete user_path(@user)
	end
	assert_redirected_to login_url
  end
  test "should redirect destroy when logged in"  do
	log_in_as(@user)
	assert_difference 'User.count', -1 do 
		delete user_path(@user1)
  	end
	assert_redirected_to users_url
  end

end
