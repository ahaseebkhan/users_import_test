Rails.application.routes.draw do
  root "users#index"

  resources :users, only: %i(index) do
    post :import_users, on: :collection
  end
end
