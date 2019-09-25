Rails.application.routes.draw do
      root 'toppage#index'
      get "about" => "toppage#about",as: 'about'

      1.upto(18) do |n|
        get"lesson/step#{n}(/:name)" => "lesson#step#{n}"

        resources :members do
          get "search",on: :collection
        end
        resource :session, only: [:create, :destroy]
        resource :account, only: [:show, :edit, :update]
        resource :password, only: [:show, :edit, :update]

        resources :articles
      end
end
