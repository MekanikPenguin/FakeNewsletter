# config/routes.rb
Rails.application.routes.draw do
  root 'articles#index'

  resources :articles, only: [:index, :destroy] do
    collection do
      get :extract
      post :process_articles
    end

    member do
      patch :add_to_newsletter
      patch :remove_from_newsletter
    end
  end

  resources :subscribers, only: [:index, :create, :destroy]
end
