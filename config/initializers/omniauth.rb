Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :twitter, Rails.application.secrets.twitter_consumer_key, Rails.application.secrets.twitter_consumer_secret,
  	{
  		:secure_image_url => 'true',
  		:image_size => 'original',
  		:authorize_params => {
  			:force_login => 'true',
  			:lang => 'pt'
  		}
  	}
end