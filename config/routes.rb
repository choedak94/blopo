Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :blog_posts do
    collection do
      get :dashboard
      get :index
    end
    member do
      post :like
      post :dislike
    end
  end
  resources :comments, only: [:create, :destroy]
  resource :language, only: [:update]
  root "blog_posts#dashboard"
end
