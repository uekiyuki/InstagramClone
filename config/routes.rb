Rails.application.routes.draw do
  # Rails.application.routes.draw do
    root 'feeds#index'
    # authenticated :user do
    resources :feeds do
      collection do
        post :confirm
      end
    end
  
    get 'sessions/new'
    resources :sessions, only: [:new, :create, :show, :destroy]
    resources :users
    resources :favorites, only: [:create, :destroy]
    
    get 'favorites/:id', to: 'favorites#index'
    mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end

