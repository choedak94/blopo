Rails.application.routes.draw do
  devise_for :users
  resources :blog_posts do
    collection do
      get :dashboard
      get :index
    end
  end
  root "blog_posts#dashboard"
end
