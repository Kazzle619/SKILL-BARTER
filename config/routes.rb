Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest'
    post 'users/chat_opponent_sign_in', to: 'users/sessions#chat_opponent'
  end

  root 'users#top'

  resources :users, only: [:index, :edit, :show, :update, :destroy] do
    resources :follows, only: [:create, :destroy]

    resources :blocks, only: [:create, :destroy]

    collection do
      get 'mypage'
      get 'notice'
      get 'search'
    end

    member do
      get 'blocking'
      get 'favorites'
      get 'followers'
      get 'following'
    end
  end

  resources :user_prefectures, only: [:create, :destroy]

  resources :background_schools, only: [:create, :destroy]

  resources :background_jobs, only: [:create, :destroy]

  resources :propositions do
    collection do
      get 'mypage_index'
      get 'offer'
      get 'search'
    end

    member do
      get 'finish'
      get 'match'
    end

    # propositionsとネスト
    resources :offers, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :reviews, only: [:new, :create, :edit, :update]
    resources :proposition_categories, only: [:create, :destroy]
    resources :request_categories, only: [:create, :destroy]
  end

  resources :achievements, only: [:index, :create, :new, :edit, :update, :destroy] do
    resources :achievement_categories, only: [:create, :destroy]
  end

  resource :tag, only: [:create]

  resources :skill_categories, only: [:create, :destroy]

  resource :room, only: [:create]

  resources :chat_messages, only: [:destroy]
end
