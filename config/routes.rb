Rails.application.routes.draw do
      root 'toppage#index'
      get "about" => "toppage#about",as: 'about'

      1.upto(18) do |n|
        get"lesson/step#{n}(/:name)" => "lesson#step#{n}"

        resources :members do
          get "search",on: :collection
          resources :entries, only: [:index] #ネストされたリソース indexアクションのみ使用
        end
        resource :session, only: [:create, :destroy]
        resource :account, only: [:show, :edit, :update]
        resource :password, only: [:show, :edit, :update]

        resources :articles
        resources :entries
      end
end
