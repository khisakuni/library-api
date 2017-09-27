Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :books, only: [:create]
      resources :users, only: [:create] do
        resources :user_books, only: %i[create update]
      end
    end
  end
end
