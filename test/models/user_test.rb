require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
    def setup
	@user = User.new(name:"sophia",email:"TianTang@outlook.com",password:"wahaha",password_confirmation:"wahaha")
    end
    test "should be valid" do
	assert @user.valid?
    end
    test "name should be present" do
	@user.name = "   "
	assert_not @user.valid?
    end
    test "name should not be too long" do
	@user.name = "a" * 60
	assert @user.valid?
    end
    test "email format" do
	invalid_add = %w[user@example,com mafoo.com]
	invalid_add.each do |inva|
		@user.email = inva
		assert_not @user.valid?, "#{inva.inspect}"
    	end
     end
    test "email add should be uniq" do
	
	duplicate_user = @user.dup
	duplicate_user.email = @user.email.upcase
	@user.save
	assert_not duplicate_user.valid?
    end
    test "email should be downcase before_saved" do
	addr = "HOt@fdFds.coM"
	@user.email = addr
	@user.save
	assert_equal addr.downcase, @user.reload.email
    end
    test "password   should be present" do
	@user.password = @user.password_confirmation = " "
	assert_not @user.valid?
    end
    test "password should be not too short" do
	@user.password = @user.password_confirmation= "5455"
	assert_not @user.valid?
    end
    test "authenticated? should return false for a user with nil digest" do
	assert_not @user.authenticated?(:remember, '')
    end
end
