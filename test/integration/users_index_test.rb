require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:lana)
    @admin = users(:michael)
    @non_admin = users(:archer)
  end

  test "index including pagination" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
#    assert_select 'div.pagination', count: 2

#    User.paginate(page: 1).each do |user|
#      assert_select 'a[href=?]', user_path(user), text: user.name

#    first_page_of_users = User.paginate(page: 1)
#    first_page_of_users.each do |user|
    inactive_count = 0
    assigns(:users).each do |user|
      if !user.activated?
        inactive_count += 1
      end
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_equal User.count-inactive_count, User.count-1
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

#  test "index as admin including pagination and delete links" do
#    log_in_as(@admin)
#    get users_path
#    assert_template 'users/index'
#    assert_select 'div.pagination'
#    first_page_of_users = User.paginate(page: 1)
#    first_page_of_users.each do |user|
#      assert_select 'a[href=?]', user_path(user), text: user.name
#      unless user == @admin
#        assert_select 'a[href=?]', user_path(user), text: 'delete'
#      end
#    end
#    assert_difference 'User.count', -1 do
#      delete user_path(@non_admin)
#    end
#  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assigns(:users).each do |user|
      assert user.activated?
    end
    assert_select 'a', text: 'delete', count: 0
  end

end
