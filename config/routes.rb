class AuthenticatedConstraint
  def matches?(request)
    request.session['user_id'].present?
  end
end

Rails.application.routes.draw do
  #mount RailsAdmin::Engine => '/admin', as: 'rails_admin'  　　　devise導入したら使う
  constraints AuthenticatedConstraint.new do
    root to: 'projects#index', as: :user_root
  end
  
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users do
    member do
      get :followings
      get :followers
    end
  end
  
  #get 'projects/category', to: 'projects#category_index'

  #get 'projects/category/language', to: 'projects#category_index'
  #get 'projects/category/club', to: 'projects#category_index'
  #get 'projects/category/event', to: 'projects#category_index'
  #get 'projects/category/study', to: 'projects#category_index'
  #get 'projects/category/job', to: 'projects#category_index'
  #get 'projects/category/debate', to: 'projects#category_index'
  #get 'projects/category/business', to: 'projects#category_index'
  #get 'projects/category/sports', to: 'projects#category_index'
  #get 'projects/category/travel', to: 'projects#category_index'
  #get 'projects/category/hobby', to: 'projects#category_index'
  #get 'projects/category/music', to: 'projects#category_index'
  #get 'projects/category/picture', to: 'projects#category_index'
  #get 'projects/category/art', to: 'projects#category_index'
  #get 'projects/category/game', to: 'projects#category_index'
  #get 'projects/category/technology', to: 'projects#category_index'
  #get 'projects/category/others', to: 'projects#category_index'
  resources :projects, only: [:index, :show, :new, :create, :update] do
    member do
      put :call_off
      resources :comment_to_projects, only: [:index, :create, :edit, :update, :destroy]
    end
    collection do
      get 'all', to: 'projects#all_projects'
      get 'fresh', to: 'projects#fresh_projects'
      get 'popular', to: 'projects#popular_projects'
      get 'closing_soon', to: 'projects#closing_soon_projects'
      get 'category/:id', to: 'projects#category_projects'
      get 'search', to: 'projects#searched_projects'
    end
  end
  resources :user_relationships, only: [:create, :destroy]
  resources :applikations, only: [:create, :update] do
    member do
      put :cancel
      put :rejoin
    end
  end
  resources :project_favorites, only: [:create, :destroy]
end
