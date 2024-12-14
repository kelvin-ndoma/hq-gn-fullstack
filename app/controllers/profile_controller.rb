class ProfilesController < ApplicationController
    before_action :authenticate_user!
  
    # Edit action to load the current user's details into the form
    def edit
      @user = current_user
    end
  
    # Update action to save changes to the user profile
    def update
      @user = current_user
      if @user.update(profile_params)
        redirect_to edit_dashboard_profile_path, notice: "Your profile has been updated successfully"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    private
  
    # Define allowed parameters for profile updates
    def profile_params
      params.require(:user).permit(:first_name, :last_name, :bio, :city, :country)
    end
  end
  