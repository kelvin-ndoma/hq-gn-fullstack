Rails.application.routes.draw do
  resource :registration
  resource :session
  resource :password_reset
  resource :password

  root "pages#index" # Set home as the default page
end
