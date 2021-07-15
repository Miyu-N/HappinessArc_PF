Rails.application.routes.draw do
  namespace :public do
    get 'categories/show'
  end
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
    
    resources :users, only: [:show, :edit, :update, :destroy] 
    get 'users/unsubscribe' => 'users#unsubscribe'
    patch 'users/withdraw' => 'users#withdraw'
    
    resources :posts do
      resources :likes, only: [:create, :destroy]
    end  
  
    
    
    resources :contacts, only: [:new, :create]
    post 'contacts/confirm' => 'contacts#confirm', as: 'contacts_confirm'
    post 'contacts/back' => 'contacts#back'
    get 'contacts/done' => 'contacts#done'
    
    resources :chats, only: [:show, :create]
    resources :rooms, only: [:index]
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
  end  
  resources :contacts, only: [:index, :show]
  
end
