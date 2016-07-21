class VolunteersController < ApplicationController
    before_action :logged_in_user, only: [:new, :create, :destroy]

    def new
        @trial = Trial.find(params[:trial_id])
        @volunteer = current_user.volunteers.build(trial: @trial)
    end

    def create
        @volunteer = current_user.volunteers.build(volunteer_params)
        if @volunteer.save
            flash[:success] = "Thank you for volunteering!"
            redirect_to root_url
        else
            render 'trials'
        end

    end

    def destroy
    end

        private

            def volunteer_params
                params.require(:volunteer).permit(:notes)
            end

end
