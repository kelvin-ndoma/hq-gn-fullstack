class SessionsController < ApplicationController
  # Show the login form
  def new
    @user = User.new
  end

  # Handle login submission
  def create
    @user = User.find_by(email: params[:user][:email])

    if @user&.authenticate(params[:user][:password])
      login @user
      redirect_to dashboard_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  # Handle logout
  def destroy
    logout current_user
    redirect_to root_path, notice: "You have been logged out."
  end
end
