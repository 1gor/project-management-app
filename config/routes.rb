Rails.application.routes.draw do
  post '/projects', to: 'projects#create'
  put '/projects/:uuid/estimate', to: 'projects#estimate'
  put '/projects/:uuid/assign_developer', to: 'projects#assign_developer'
  get '/projects', to: 'projects#index'
  get '/projects/:uuid', to: 'projects#show'

  get '/developers', to: 'developers#index'
  post '/developers', to: 'developers#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
