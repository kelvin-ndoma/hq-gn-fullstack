class ApplicationController < ActionController::Base
  # Set the layout dynamically based on user authentication status
  before_action :set_layout

  private

  def dashboard_page?
    controller_name == 'dashboard' # Or use any condition based on your routing logic
  end
  
  # Set layout based on whether the user is signed in or not
  def set_layout
    if user_signed_in?
      self.class.layout "dashboard_layout"  # Use dashboard layout for signed-in users
    else
      self.class.layout "application"  # Use home layout for non-signed-in users
    end
  end

  # Redirect user after sign-in to the dashboard
  def after_sign_in_path_for(resource)
    dashboard_path
  end

  # Authenticate user and redirect if not signed in
  def authenticate_user!
    redirect_to root_path, alert: "Please Login" unless user_signed_in?
  end

  # Get the current user from session or authenticate if necessary
  def current_user
    Current.user ||= authenticate_user_from_session
  end
  helper_method :current_user

  # Find the user by session ID (used for authentication)
  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  # Check if the user is signed in
  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  # Log the user in and store in session
  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  # Log the user out and clear the session
  def logout(user)
    Current.user = nil
    reset_session
  end
end
