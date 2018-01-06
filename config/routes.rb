Rails.application.routes.draw do
  get 'sessions/new'

  resources :users
  # 確認画面へのルーティング追加
  resources :posts do
    collection do
      post :confirm
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions

  # 追記
  resources :favorites, only: [:create, :destroy]

  # トップページのルーティング
  root :to => 'posts#index'
end
