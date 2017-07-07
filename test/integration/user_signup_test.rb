require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup info" do
	get signup_path
	assert_difference 'User.count' do
		post users_path, params: { user: { name: "xze",
						   email: "user@valid.com",
						   password: "123456",
						   password_confirmation: "123456" } }
	end
	follow_redirect!
        assert_template 'users/show'
	
  end
end
