require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

    def setup
        @user = users(:john)
        @nonadmin = users(:petra)
    end

    test "unsuccessful edit" do
        log_in_as(@user)

        get edit_user_path(@user)
        assert_template 'users/edit'
        patch user_path(@user), params: { user: { 
            name: "",
            email: "foo@invalid",
            mobile: "2",
            password: "foo",
            password_confirmation: "bar" 
        } }
        assert_template 'users/edit'
    end

    test "successful edit with forwarding" do
        get edit_user_path(@user)
        log_in_as(@user)
        assert_redirected_to edit_user_path(@user)

        name = "Foo Bar"
        email = "foo@bar.com"
        mobile = "384756345"
        patch user_path(@user), params: { user: { 
            name: name,
            email: email,
            mobile: mobile,
            password: "",
            password_confirmation: "" 
        } }
        assert_not flash.empty?
        assert_redirected_to @user

        @user.reload
        assert_equal name, @user.name
        assert_equal email, @user.email
    end

    test "users can't create admins" do
        log_in_as(@nonadmin)

        get edit_user_path(@nonadmin)
        assert_template 'users/edit'
        patch user_path(@nonadmin), params: { user: { 
            name: "Foo Bar",
            email: "foo@bar.com",
            mobile: "897683475903475",
            admin: "1",
            password: "",
            password_confirmation: "" 
        } }
        assert_template 'users/edit'
    end

    test "admins can create admins" do
        log_in_as(@user)

        get edit_user_path(@nonadmin)
        assert_equal false, @nonadmin.admin

        assert_template 'users/edit'
        patch user_path(@nonadmin), params: { user: { 
            admin: "1"
        } }
        assert_not flash.empty?
        assert_redirected_to @nonadmin

        @nonadmin.reload
        assert_equal true, @nonadmin.admin
    end

end
