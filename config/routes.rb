Xlogger::Application.routes.draw do |map|
  # map.connect ':controller/:action/:id'
  # params = { :controller => 'blog',
  #            :action => 'edit', 
  #            :id    =>  '22'
  #            }

  # sets up a default map
  #map.connect ':controller/:action/:id', :controller => 'pages'
  resources :workouts
  resources :warmups
  resources :templates
  resources :exercises
  resources :entries
  resources :users
  resources :events
  resources :sessions, :only => [:new, :create, :destroy]

  get "calendar/index"
  get "templates/index"  ### < maybe

  get "pages/home"
  get "pages/contact"
  get "pages/about"
  get "pages/help"
  

  map.signup 'signup', :controller => 'users', :action => 'new'
  map.signin 'signin', :controller => 'sessions', :action => 'new'
  map.signout 'signout', :controller => 'sessions', :action => 'destroy'

  map.contact 'contact', :controller => 'pages', :action => 'contact'
  map.about 'about', :controller => 'pages', :action => 'about'
  map.help 'help', :controller => 'pages', :action => 'help'

  map.calendar 'calendar', :controller => 'calendar', :action => 'index'

  map.root :controller => 'pages', :action => 'home'
end  
