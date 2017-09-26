Rails.application.routes.draw do
  get '/gdrive_files' => 'google_oauths#get_drive_files', as: :gdrive_files
  get '/gdrive_files/callback' => 'google_oauths#get_drive_files_callback'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :employees

  resources :users

  resources :services

  resources :slackbots

  resources :trellobots

  resources :google_oauths, only: [:new]

  resources :jobs do
		resources :slacksubscriptions, only: [:new]
	end

	resources :slacksubscriptions, only: [:create]

  resources :jobs do
    resources :trellosubscriptions, only: [:new]
  end

  resources :trellosubscriptions, only: [:create]

  resources :jobs do
    resources :googlesubscriptions, only: [:new]
  end

  resources :googlesubscriptions, only: [:create]



  root 'employees#index'


end
