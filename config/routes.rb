Rails.application.routes.draw do
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 
# ====ユーザー側====
  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations',
    passwords: 'public/users/passwords',
  }
  
  # # ====ゲストユーザー側====
  # devise_scope :user do
  #   post 'public/users/guest_sign_in', to: 'public/users/sessions#guest_sign_in'
  # end


  get 'search/search'
  scope module: :public do
    root to: 'homes#top'
    get 'posts/search' => 'posts#search'
    

    resources :users, only: [:show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
    	get 'followings' => 'relationships#followings', as: 'followings'
  	  get 'followers' => 'relationships#followers', as: 'followers'
    end
      get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
      patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw'


    resources :posts do
      resource :likes, only: [:create, :destroy]
      
    end
    
    get 'posts/:id/likes' => 'posts#like', as: 'like_index'



    resources :contacts, only: [:new, :create] do
      collection do
        post 'confirm' => 'contacts#confirm', as: 'contacts_confirm'
        post 'back' => 'contacts#back'
        get 'done' => 'contacts#done'
      end
    end
    
    resources :chats, only: [:show, :create]
    resources :rooms, only: [:index]
  end


#====管理側====
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords'
  }

  namespace :admin do
  get '/' => 'posts#index', as: 'top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :categories, only: [:index, :create, :edit, :update]
    resources :posts, only: [:index, :show]
    resources :contacts, only: [:index, :show]
  end


end
