Rails.application.routes.draw do
  namespace :v1 do
    resources :store, only: [] do
      resources :items, only: [:index, :update] do
        collection do
          get 'add_price'
        end
      end

    end

  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
