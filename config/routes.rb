Rails.application.routes.draw do

  get '/profile', to: 'application#profile'

  get '/auth/:provider/callback', to: 'sessions#create'

end
