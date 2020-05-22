Rails.application.routes.draw do
  get 'achievements/new'
  get 'achievements/edit'
  get 'propositions/index'
  get 'propositions/new'
  get 'propositions/edit'
  get 'propositions/show'
  get 'propositions/mypage_index'
  get 'propositions/offer'
  get 'propositions/search'
  get 'propositions/finish'
  get 'propositions/match'
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
