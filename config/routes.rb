Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :boabom_courses
    resources :course_subscriptions

    root to: "users#index"
  end

  get 'products/:id', to: 'products#show', :as => :products
  devise_for :users, :controllers => { :registrations => 'registrations' }
  devise_scope :user do
    post 'pay', to: 'registrations#pay'
  end
  resources :users
  root :to => 'visitors#index'
end
