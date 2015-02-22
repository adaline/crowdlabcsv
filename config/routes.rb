Rails.application.routes.draw do
  root 'projects#index'

  resources :projects do
    resources :users
    post 'verify_import' => 'users#verify_import'
    post 'process_import' => 'users#process_import'
  end
end
