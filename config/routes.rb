Rails.application.routes.draw do 
  namespace :api do 
    namespace :v1 do 
      resources :users, only: :create
      devise_for :users, 
            skip: [:passwords, :registrations], 
            path: '', 
            controllers: {
              sessions: 'api/v1/sessions'
            }, 
            path_names: {
              sign_in: 'auth/login',
              sign_out: 'auth/logout'
            }
      resources :bucket_lists do 
        resources :items
      end            
    end
  end
  get '/', :to => redirect('/api/docs/index.html')
  get '/tester', :to => redirect('/api/tester/index.html')
  match '*url', to: 'errors#invalid_route', via: :all 
end
