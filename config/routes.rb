Rails.application.routes.draw do

  root 'landing#index'

  devise_for :users

  scope :profile do
    resources :profile, only: [:edit, :update]
    get '/' => 'profile#index', as: :profile_page
    get 'edit/account' => 'profile#edit', as: :edit_user_account

    devise_scope :user do
      get 'edit/password' => 'devise/registrations#edit', as: :edit_user_account_password
    end
  end

  resources :users, only: [:index, :show] do
    collection do
      get :search
      get :export_csv, as: :export
    end
  end

  resources :categories do
    resources :items

    collection do
      get :search
      get 'export' => 'categories#export_sample_csv', as: :export
      post :import
    end
  end

  resources :items, except: [:index] do
    collection do
      get :search
    end
  end

  resources :user_items do
    collection do
      get :order_history
      get :buy_all
      get :delete_all
    end
  end

  resources :ratings, only: [:new, :create]

end