Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/home" => "welcome#index"
  get "/about" => "welcome#about_me", as: :about_us
  get "/contact" => "contact#new", as: :new_contact
  post "/contact" => "contact#create",  as: :contact
  root "welcome#index"

  resources :questions
  # get "/questions/new" => "questions#new", as: :new_question
  # post "/questions" => "questions#create", as: :questions
  # get "/questions/:id" => "questions#show",   as: :question
  # get "/questions" => "questions#index"
  # get "/questions/:id/edit" => "questions#edit",   as: :edit_question
  # patch "/questions/:id" => "questions#update"
  # delete "/questions/:id" => "questions#destroy"
end
