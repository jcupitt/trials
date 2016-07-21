Rails.application.routes.draw do
    resources :trials
    get 'sessions/new'

    get 'users/new'

    root 'trials#index'

    get '/help', to: 'static_pages#help'
    get '/about', to: 'static_pages#about'
    get '/contact', to: 'static_pages#contact'

    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    get  '/signup', to: 'users#new'

    get  '/volunteer', to: 'volunteers#new'

    resources :users
end

