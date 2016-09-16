class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update, :show]
    before_action :correct_user, only: [:edit, :update, :show]
    before_action :admin_user, only: [:destroy, :index]
    before_action :admin_only_admin, only: [:edit, :update]

    def new
        @user = User.new
    end

    def show
        @volunteers = @user.volunteers.paginate(page: params[:page])
    end

    def index
        @users = User.paginate(page: params[:page])
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in @user
            flash[:success] = "Welcome to Imperial Trials!"
            redirect_to @user
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @user.update_attributes(user_params)
            flash[:success] = "Profile updated"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User deleted"
        redirect_to users_url
    end

    private

        def user_params
            params.require(:user).permit(:name, :email, :mobile, :admin,
                                         :password, :password_confirmation)
        end

        def admin_only_admin
            if params[:user] && user_params[:admin] != "0" && !is_admin?
                flash[:danger] = "Only admins can create admins" 
                redirect_to 'edit'
            end
        end

end
