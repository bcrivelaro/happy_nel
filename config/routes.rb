Rails.application.routes.draw do
  devise_for :admins, only: :sessions

  devise_scope :admin do
    unauthenticated do
      root to: 'devise/sessions#new', as: 'unauthenticated_root'
    end
  end
end
