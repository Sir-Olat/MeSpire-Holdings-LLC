Rails.application.routes.draw do

  devise_for :admins
  resources :forms

  root 'jobs#index'
  resources :jobs do
    put 'published' => 'jobs#publish', on: :member
    put 'unpublished' => 'jobs#unpublish', on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
