Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  resources :users, only: [:new, :create]
  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection
    # :collection tells we don't need to pass id
  end

  get "/home" => "welcome#index"
  get "/about" => "welcome#about_me", as: :about_us
  get "/contact" => "contact#new", as: :new_contact
  post "/contact" => "contact#create",  as: :contact
  root "welcome#index"


  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :questions, only: [:index, :show]
    end
  end


  # get 'api/v1/questions' => 'api/v1/questions#index'

  resources :questions do
    # # collection is used when we don't need to specify a particular question but we expect a collection of question. Examples: index / create
    # post :search, on: :collection
    #
    # # member is used when we need to identify a particular question. Examples are: show / edit / update / destroy
    # post :search, on: :member
    #
    # # This is when we want to have nested routes for our resources. Example: answers for questions.
    # post :search

    resources :answers, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    resources :votes, only: [:create, :update, :destroy]
  end

  # get "/questions/new" => "questions#new", as: :new_question
  # post "/questions" => "questions#create", as: :questions
  # get "/questions/:id" => "questions#show",   as: :question
  # get "/questions" => "questions#index"
  # get "/questions/:id/edit" => "questions#edit",   as: :edit_question
  # patch "/questions/:id" => "questions#update"
  # delete "/questions/:id" => "questions#destroy"
end
