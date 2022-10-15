Rails.application.routes.draw do

  root 'top#index'
  resources :diaries
  resources :emotion_logs
end
