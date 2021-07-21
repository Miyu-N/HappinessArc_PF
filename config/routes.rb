Rails.application.routes.draw do
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# ====ユーザー側====
  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations',
    passwords: 'public/users/passwords',
  }

  get 'search/search'
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'

    resources :users, only: [:show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
    	get 'followings' => 'relationships#followings', as: 'followings'
  	  get 'followers' => 'relationships#followers', as: 'followers'
    end
      get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
      patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw'


    resources :posts do
      resources :likes, only: [:create, :destroy]
    end



    resources :contacts, only: [:new, :create] do
      collection do
        post 'confirm' => 'contacts#confirm', as: 'contacts_confirm'
        post 'back' => 'contacts#back'
        get 'done' => 'contacts#done'
      end
    end
    
    resources :chats, only: [:create]
    resources :rooms, only: [:show, :create]
  end


#====管理側====
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords'
  }

  namespace :admin do
  get '/' => 'homes#top', as: 'top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :categories, only: [:index, :create, :edit, :update]
    resources :posts, only: [:index, :show]
    resources :contacts, only: [:index, :show]
  end


end
