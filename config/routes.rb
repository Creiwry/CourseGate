# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :instructors
  devise_for :students
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'
  get 'about_us', to: 'static#about_us', as: :about_us
  get 'faq', to: 'static#faq', as: :faq
  resources :courses
  resources :forum_threads
  resources :forum_posts
  resources :enrollments
end
