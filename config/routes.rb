Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  devise_for :users, :path => '', :path_names => {:sign_in => 'signin', :sign_up => 'signup'}
  resources :contacts
  get '/home' => "main#index"
  get '/sign_in' => "sessions#new"
  resources :emails do
    collection do
      get 'inbox'
      get 'outbox'
      get 'draft'
      get 'detail'
    end
  end
  resources :notifications
end
