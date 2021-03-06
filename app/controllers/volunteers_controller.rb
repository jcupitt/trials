class VolunteersController < ApplicationController
    before_action :correct_user, only: [:edit, :update, :show]
    before_action :recruiter_user, only: [:index]
    before_action :admin_user, only: [:destroy, :index]

    def new
        @trial = Trial.find(params[:trial_id])

        # if we're not logged in, we need a blank user to create as well
        @user = logged_in? ? current_user : User.new

        @volunteer = @user.volunteers.build(trial: @trial)

        # if we're a recruiter, we will show all volunteers for this trial
        if @user.recruiter_or_admin?
            @volunteers = @trial.volunteers
        end
    end

    def show
        @volunteer = Volunteer.find(params[:id])
    end

    def index
        @volunteers = Volunteer.order("updated_at").
            paginate(:page => params[:page])
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
            else
                # the 'new' view needs @volunteer ... copy the errors from 
                # @user up into our new @volunteer
                @volunteer = @user.volunteers.
                    build(volunteer_params.merge(trial: @trial))
                @user.errors.each do |attribute, message|
                    @volunteer.errors.add(attribute, message)
                end
                render 'new'
            end
        end

        if @user.valid?
            @volunteer = @user.volunteers.
                build(volunteer_params.merge(trial: @trial))
            if @volunteer.save
                flash[:success] = "Thank you for volunteering!"
                redirect_to root_url
            else
                render 'new'
            end
        end
    end

    def edit
        @volunteer = Volunteer.find(params[:id])
    end

    def update
        @volunteer = Volunteer.find(params[:id])
        if @volunteer.update(volunteer_params)
            flash[:success] = "Expression of interest updated"
            redirect_to @volunteer
        else
            render 'edit'
        end
    end

    def destroy
    end

        private

            def volunteer_params
                params.require(:volunteer).permit(:notes)
            end

            def user_params
                params.require(:user).permit(:name, :email, :mobile,
                                             :password, :password_confirmation)
            end

end
