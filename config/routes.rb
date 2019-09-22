Rails.application.routes.draw do
  devise_for :admins, only: :sessions

  devise_scope :admin do
    authenticated :admin do
      root to: 'members#index'
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :members, except: :show
  resources :surveys, only: %i[index new create]

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
