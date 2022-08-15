Rails.application.routes.draw do
  resources :gigs do
    get 'set_completed', :on => :member
  end
  resources :gig_payments do
    get 'set_complete', :on => :member
  end
  resources :users
  resources :creators
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
