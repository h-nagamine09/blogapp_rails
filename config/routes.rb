Rails.application.routes.draw do
  root 'toppage#index'
  get "about" => "toppage#about",as: 'about'
  get "bad_request" => "toppage#bad_request"
  get "forbidden" => "toppage#forbidden"
  get "internal_server_error" => "toppage#internal_server_error"

  1.upto(18) do |n|
    get "lesson/step#{n}(/:name)" => "lesson#step#{n}"
  end

  resources :members, only: [:index, :show] do
    get "search", on: :collection
    resources :entries, only: [:index] #ネストされたリソース indexアクションのみ使用
  end

  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resource :password, only: [:show, :edit, :update]

  resources :articles, only: [:index, :show]
  resources :entries do
    patch "like", "unlike", on: :member
    get "voted", on: :collection
    resources :images, controller: "entry_images" do
      patch :move_higher, :move_lower, on: :member
    end
  end
  
#管理ページ
  namespace :admin do
    root to: "toppage#index"
    resources :members do
      get "search", on: :collection
    end
    resources :articles
  end
end
