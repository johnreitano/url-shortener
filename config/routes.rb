Rails.application.routes.draw do
  devise_for :users
  resources :shortened_urls

  root 'pages#welcome'
  get '/cannot-redirect', to: 'pages#cannot_redirect'#, as: 'cannot_redirect'
  get ':short_path', to: 'pages#redirect', id: /[A-Za-z0-9]{4}/

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
