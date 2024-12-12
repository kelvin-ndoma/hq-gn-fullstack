class PasswordResetsController < ApplicationController
    before_action :set_user_by_token, only: [:edit, :update]
  
    def new
        @user = User.new
      end
      
  
      def create
        email = params.dig(:user, :email) # Safely fetch the email
        if email.present? && (user = User.find_by(email: email))
          PasswordMailer.with(
            user: user,
            token: user.generate_token_for(:password_reset) # Ensure your User model has this method
          ).password_reset.deliver_later
          redirect_to root_path, notice: "Check your email to reset your password"
        else
          redirect_to new_password_reset_path, alert: "Email not found. Please try again."
        end
      end
      
  
    def edit
      # Render form for resetting the password (this will include a hidden token field)
    end
  
    def update
      if @user.update(password_params)
        redirect_to new_session_path, notice: "Password has been reset successfully, Please login in"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_user_by_token
        @user = User.find_by_token_for(:password_reset, params[:token]) # Ensure User model has this method
        redirect_to new_password_reset_path, alert: "Invalid token, try again" unless @user.present?
      end
      
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
  