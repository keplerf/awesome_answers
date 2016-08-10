Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/home" => "welcome#index"
  get "/about" => "welcome#about_me", as: :about_us
  get "/contact" => "contact#new", as: :new_contact
  post "/contact" => "contact#create",  as: :contact
  root "welcome#index"
end
