Rails.application.routes.draw do
      root 'toppage#index'
      get "about" => "toppage#about",as: 'about'

      1.upto(18) do |n|
        get"lesson/step#{n}(/:name)" => "lesson#step#{n}"
      end
end
