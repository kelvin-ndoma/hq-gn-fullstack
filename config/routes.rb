Rails.application.routes.draw do
  resource :registration
  resource :session
  resource :password_reset
  resource :password

  get "/dashboard", to: "dashboard#index" # Authenticated user dashboard
  root "pages#index" # Set home as the default page
end
