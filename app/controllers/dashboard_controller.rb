class DashboardController < ApplicationController
    before_action :authenticate_user!
  
    def index
      # Add any logic needed for the dashboard
    end
  end
  