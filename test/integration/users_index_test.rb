require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
	@user = users(:lansscar)
	@user1 = users(:lanssca)
  end

  test "index including paginate delete links" do
	log_in_as(@user)
	get users_path
	assert_template 'users/index'
	assert_select 'div.pagination'
	first_page_of_users = User.paginate(page: 1)
	first_page_of_users.each do |user|
		assert_select 'a[href=?]', user_path(user), text: user.name
		unless user == @user
			assert_select 'a[href=?]', user_path(user), text: 'delete'
		end
	end
	assert_difference 'User.count', -1 do
		delete user_path(@user1)
	end
  end

  test "index as non-admin" do
	log_in_as(@user1)
	get users_path
	assert_select 'a', text: 'delete', count: 0
  end
	
end
