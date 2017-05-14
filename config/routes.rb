Rails.application.routes.draw do
  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  mount Facebook::Messenger::Server, at: 'bot'
  
  root to: "messages#index"
end
