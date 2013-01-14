Sortable::Application.routes.draw do

  resource :home, controller: 'home', only: 'show'
  resources :todo_lists do
    member do
      post 'update_row'
    end

    collection do
      post 'move_row'
    end
  end

  # root path application
  root :to => "home#show"

end
