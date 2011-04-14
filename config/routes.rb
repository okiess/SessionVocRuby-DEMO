Sessionvoc::Application.routes.draw do
  get "main/index"
  
  match 'wizard' => 'main#wizard', :as => :wizard
  match 'wizard_step2' => 'main#wizard_step2', :as => :wizard_step2
  match 'wizard_step3' => 'main#wizard_step3', :as => :wizard_step3

  match 'nonce' => 'main#nonce', :as => :nonce
  match 'check_nonce' => 'main#check_nonce', :as => :check_nonce

  resources :sessions
  match 'login' => 'sessions#new'
  match 'logout' => 'sessions#destroy'
  
  root :to => "main#index"
end
