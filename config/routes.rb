Rails.application.routes.draw do
  resources :parameter_kinds
  resources :tests
  resources :test_kinds
  root to: 'landing#index'

  # Landing
  get 'landing/index', as: 'landing'

  namespace :api do
    resources :creatinine_tests, only: [:create]
  end

  post 'landing/create', to: 'landing#create', as: 'create_contact'

  get 'sudo', as: 'sudo', to: 'landing#sudo'

  resources :aki_diagnoses
  resources :creatinine_tests
  resources :imports, only: [:show, :new, :create] do
    member do
      get :valid_import_results
      get :invalid_import_results
    end
  end

  resources :users do
    collection do
      get ':id/change_password', to: 'users#change_password', as: 'change_password'
      get ':id/choose_plan', to: 'users#choose_plan', as: 'choose_plan'
      get ':id/welcome', to: 'users#register_message', as: 'register_message'
      post ':id/create_institution_and_plan', to: 'users#create_institution_and_plan', as: 'create_institution_and_plan'
      post ':id/add_user_to_institution', to: 'users#add_user_to_institution', as: 'add_user_to_institution'
    end
  end

  resources :institutions do
    get 'reports/index', as: 'reports'
    resources :alerts, only: [:index]
    resources :imports, only: [:show, :new, :create]
    resources :aki_diagnoses
    resources :creatinine_tests
    resources :epicrises
    resources :users
    resources :triggers
    resources :patients do
      get 'compare/:parameter_kind_id_1', as: :compare, to: 'compare#index'
      get 'compare/get_comparable_parameters/:parameter_kind_id', as: :get_comparable_parameters, to: 'compare#get_comparable_parameters'
      collection do
        get :search
      end
      resources :parameter_kinds
      resources :parameter_group_kinds do
        resources :parameter_groups
        resources :parameter_kinds
      end
    end
    # delete after doctor Andres Boltanksy it's ready to buy
    resources :boltanksy do
      member do
        get :login
      end
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'


  get 'admin', to: 'admin/parameter_group_kinds#index'
  namespace :admin do
    resources :parameter_group_kinds
    resources :parameter_kinds
    resources :alert_kinds
  end
end
