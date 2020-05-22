Rails.application.routes.draw do
  get 'users/top'
  get 'users/index'
  get 'users/mypage'
  get 'users/edit'
  get 'users/show'
  get 'users/blocking'
  get 'users/followers'
  get 'users/following'
  get 'users/notice'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
