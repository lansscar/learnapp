require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
	ActionMailer::Base.deliveries.clear
  end
  test "invalid signup info" do
	get signup_path
	assert_no_difference 'User.count' do
		post users_path, params: { user: { name: "xze",
						   email: "user@valid.com",
						   password: "12346",
						   password_confirmation: "123456" } }
	end
	assert_template 'users/new'
	assert_select 'div#error_explanation'
	assert_select 'div.field_with_errors'	
  end

end
