Rails.application.routes.draw do
  resources :gigs
  resources :gig_payments
  resources :users
  resources :creators do
    get 'search', :on => :collection
    put 'set_first_name', :on => :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
