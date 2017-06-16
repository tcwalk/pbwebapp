require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
    @another_user = users(:malory)
  end

  test "should get new" do
    get signup_path
    assert_response :success
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

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
        user: { password:              "foobar",
                password_confirmation: "foobar",
                admin: true } }
    assert_not @other_user.reload.admin?
    assert_equal @other_user.admin?, false #same as assert_not @other_user.admin?
  end

#  test "should destroy user" do
#    log_in_as(@user)
#    delete user_path(@other_user)
#    assert_not user_path(@other_user)
#  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
#    assert_difference 'User.count', 0 do
      delete user_path(@another_user)
    end
    assert_redirected_to root_url
  end



end
