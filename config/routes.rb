Rails.application.routes.draw do
  root 'projects#index'

  resources :projects do
    resources :users
    get 'fake_csv' => 'users#fake_csv'
    post 'verify_import' => 'users#verify_import'
    post 'process_import' => 'users#process_import'
  end
end
