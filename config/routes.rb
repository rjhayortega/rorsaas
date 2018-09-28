require 'sidekiq/web'

Rails.application.routes.draw do

  
  	resources :promotion_posts, path: "promotions" do
	    member do
	      get :select_people
	      post :send_to_people

	      post :deploy

	      get :select_queue
	      post :send_to_queue
	    end
  	end

  	resources :facebook_connected_accounts, shallow: true do
    	resources :facebook_ads
  	end



  	root to: 'posts#index'
  	get 'get_account_limit', to: 'pages#get_account_limit'
  	# get 'auth/twitter/callback', ''

  	# mount Delayed::Web::Engine, at: '/jobs'

  	get 'add_for_schedule', to: 'other#add_for_schedule'
    # get '/profile_setting' => 'users/:id/edit'

    match 'profile_setting' => 'users#edit', via: "get", as: "edit_user"
    # original edit_user GET    /users/:id/edit(.:format)    users#edit
  	match '/social_remove' => 'users#social_remove', via: "get", as: "social_remove"

    post '/choose_fb_pages', to: "accounts#choose_fb_pages"
    resources :reports
  	resources :posts do
	    collection do
	      post :shorten
        post :preview
	      get :draft
	    end
  	end

  	resources :organisations
  	resources :agents

  	namespace :admin, path: 'gateway' do
	    root 'posts#index'
	    resources :posts do
	      collection do
	        get :past
	        get :instagram
	      end
	    end
  	end

  	resources :enquiries do
      post :send_enquiry_info, on: :collection
    end
  	resources :properties, path: "lp" do
	    member do
	      post :increase_shares_count
	    end
	    resources :property_images
	    resources :enquiries
  	end

  	match '*all', to: proc { [204, {}, ['']] }, via: :options

    resources :queue_lists, shallow: true, path: "queues" do
	    resources :posts
	    resources :queue_posts

	    member do
	      get :activity
	      get :accounts
	      get :calendar
	      post :reschedule
	    end
  	end

  	mount Sidekiq::Web => '/sidekiq'

  	resources :profiles
  	resources :profile_pages
  	resources :accounts
  	resources :folders
  	resources :media

  	devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}, controllers: {
  		sessions: 'users/sessions',
  		registrations: 'users/registrations'
  	}

  	resources :users, only: [:index, :create] do
    	post :hack_in, on: :member
  	end

	resources :offices, shallow: true do
	    member do
	      post :take_payment
	      delete :stop_payment
	    end

	    resources :users
  	end
end
