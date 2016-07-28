Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}
  as :user do
    get '/' => 'devise/registrations#new'
  end
  mount ActionCable.server => "/cable"
  resources :grid
end
