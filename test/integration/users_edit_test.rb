require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

    def setup
        @admin = users(:john)
        @recruiter = users(:petra)
        @user = users(:nina)
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
        log_in_as(@user)

        get edit_user_path(@user)
        assert_template 'users/edit'
        patch user_path(@user), params: { user: { 
            role: "admin"
        } }
        assert_redirected_to edit_user_url
    end

    test "users can't create recruiters" do
        log_in_as(@user)

        get edit_user_path(@user)
        assert_template 'users/edit'
        patch user_path(@user), params: { user: { 
            role: "recruiter"
        } }
        assert_redirected_to edit_user_url
    end

    test "admins can create admins" do
        log_in_as(@admin)

        get edit_user_path(@recruiter)
        assert_equal "recruiter", @recruiter.role

        assert_template 'users/edit'
        patch user_path(@recruiter), params: { user: { 
            role: "admin"
        } }
        assert_not flash.empty?
        assert_redirected_to @recruiter

        @recruiter.reload
        assert_equal "admin", @recruiter.role
    end

    test "admins can create recruiters" do
        log_in_as(@admin)

        get edit_user_path(@user)
        assert_equal "user", @user.role

        assert_template 'users/edit'
        patch user_path(@user), params: { user: { 
            role: "recruiter"
        } }
        assert_not flash.empty?
        assert_redirected_to @user

        @user.reload
        assert_equal "recruiter", @user.role
    end

end
