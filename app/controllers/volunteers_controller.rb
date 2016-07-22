class VolunteersController < ApplicationController
    def new
        @trial = Trial.find(params[:trial_id])

        # if we're not logged in, we need a blank user to create as well
        @user = logged_in? ? current_user : User.new

        @volunteer = @user.volunteers.build(trial: @trial)
    end

    def create
        @trial = Trial.find(params[:trial_id])

        # if we're not logged in, create a user using the fields from the
        # contact details part of the form
        if logged_in?
            @user = current_user
        else
            @user = User.new(user_params)
            if @user.save
                log_in @user
            end
        end

        @volunteer = @user.volunteers.
            build(volunteer_params.merge(trial: @trial))
        if @volunteer.save
            flash[:success] = "Thank you for volunteering!"
            redirect_to root_url
        else
            render 'new'
        end

    end

    def destroy
    end

        private

            def volunteer_params
                params.require(:volunteer).permit(:notes)
            end

            def user_params
                params.require(:user).permit(:name, :email, 
                                             :password, :password_confirmation)
            end

end
