Rails.application.routes.draw do
  get '/pricing', to: 'pricing#index'
  put '/pricing', to: 'pricing#refresh' # in production this should be locked behind authentication or possibly a util route
end
