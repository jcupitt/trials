class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    private

        # Before filters

        def logged_in_user
            unless logged_in? 
                store_location
                flash[:danger] = "Please register your contact details."
                redirect_to signup_url
            end
        end

        def correct_user
            @user = User.find(params[:id])
            redirect_to(root_url) unless current_user?(@user) or is_admin?
        end

        def admin_user
            redirect_to(root_url) unless is_admin?
        end

        def recruiter_user
            redirect_to(root_url) unless is_recruiter? or is_admin?
        end

end
