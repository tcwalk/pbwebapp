Rails.application.routes.draw do

  get 'static_pages/home'

  get 'static_pages/help'

  get 'static_pages/about'

  get 'static_pages/contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#   if Rails.env.production?
##      root 'users#index'
#      root 'application#hello'
      root 'static_pages#home'
#   end

end
