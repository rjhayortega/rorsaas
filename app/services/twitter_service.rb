class TwitterService
  def initialize post, profile
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_consumer_key
      config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
      config.access_token        = profile.access_token
      config.access_token_secret = profile.long_live_token
    end

    @post = post
    @profile = profile

    @processed_post_text = if @post.post_url.present?
      [@post.description, @post.post_url].join(' ')
    else
      @post.description
    end
  end

  def delete_status id
    @client.destroy_status(id)
  end

  def run
    result = case @post.legacy_capatable_post_type
    when 'image'
      post_image
    when 'link'
      post_text
    when 'text'
      post_text
    end

    result.id
  end

  def post_text
    if @post.post_url.present?
      page = MetaInspector.new(@post.post_url)
      data_image = page.images.best
      data_title = page.best_title
      data_content = page.best_description

      uploader = CarrierWave::Uploader::Base.new
      uploader.download! data_image
      @processed_post_text = [@post.description, @post.post_url].join(' ')
      @client.update_with_media @processed_post_text, uploader.file.to_file
    else
      @client.update @processed_post_text
    end
  end

  def post_image
    uploader = CarrierWave::Uploader::Base.new
 
    uploader.download! 'https://app.houseq.io' + @post.legacy_capatable_image_url
    @client.update_with_media @processed_post_text, uploader.file.to_file
  end

  def post_video
    uploader = CarrierWave::Uploader::Base.new
    uploader.download! 'https://app.houseq.io' + @post.image.url
    media = @client.upload uploader.file.to_file
    resp = @client.update_with_media , media
    resp
  end

  def post_gif
    post_image
  end
end