Rails.application.routes.draw do
 
  resource :registration
  resource :session
  
  resource : password_reset
  resource :password

  root "pages#home" # Set home as the default page
end
