# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :instructors, controllers: { sessions: 'instructors/sessions/sessions' }
  devise_for :students, controllers: { sessions: 'students/sessions/sessions' }
  resources :students, only: [:show]
  resources :instructors, only: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'
  get 'about_us', to: 'static#about_us', as: :about_us
  get 'faq', to: 'static#faq', as: :faq

  resources :courses do
    resources :materials
    resources :assignments do
      resources :submissions do
        member do
          patch :score
        end
      end
    end
  end

  resources :forum_threads do
    resources :forum_posts, except: [:show]
  end
  resources :enrollments
end
