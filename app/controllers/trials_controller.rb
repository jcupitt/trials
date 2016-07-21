class TrialsController < ApplicationController
    before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

    def new
        @trial = Trial.new
    end

    def show
        @trial = Trial.find(params[:id])
    end

    def index
        @trials = Trial

        if params[:search]
            @trials = @trials.search(params[:search])
        end

        @trials = @trials.paginate(page: params[:page])
    end

    def edit
        @trial = Trial.find(params[:id])
    end

    def create
        @trial = Trial.new(trial_params)

        if @trial.save
            redirect_to trials_path
        else
            render 'new'
        end
    end

    def update
        @trial = Trial.find(params[:id])
        if @trial.update(trial_params)
            redirect_to trials_path
        else
            render 'edit'
        end
    end

    def destroy
        @trial = Trial.find(params[:id])
        @trial.destroy
                     
        redirect_to trials_path
    end

    private

        def trial_params
            params.require(:trial).permit(:name, :short_description, 
                                          :long_description, :logo_url, 
                                          :graphic_url)
        end

        def admin_user
            redirect_to(root_url) unless current_user && current_user.admin?
        end

end
