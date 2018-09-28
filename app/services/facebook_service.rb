class FacebookService
  def initialize post, profile
    token = if profile.is_a?(Profile)
      profile.long_live_token
    else
      profile.access_token
    end

    @graph = Koala::Facebook::API.new(token, Rails.application.secrets.facebook_key)
    @post = post
  end

  def self.crop_smart_client
    access_token = 'EAAKzzECHJYIBAEnmGFtJp3MBhvKPOVYTOD91ACL5GpxJkg3yDmFuH8I54jxv7gGg9yVINVZBoaZAjjgwbf8K8VAGFIZBuZCQMrsul56oUjSM9toGPuKPAdJSP56tCAlJJpNg2FphsdtXuVlTvwJy'

    Koala.configure do |config|
      config.access_token = access_token
      # config.app_access_token = 'EAACEdEose0cBAFjlsc0nHaZBsF5j9eW7sa04F0DpFPfnAHNfT7ptIcaLycVZBzkC2s21NXU6WlgBcHnQqyWr5qDZBw4vuX8mafZChdNl18IamJQ8uUMMpEOZCKsOTZCZBNOAM1Tn2fuiNUERLzwCfaxIfmIaR5xXyVHTuzouWog7QnRKSm3X0PwtFyzuUCvAG0ZD'
      config.app_id = '760639790720386'
      config.app_secret = '813d9b043f0cd4b8357274f8dd9d260e'
      config.api_version = "v2.10"

      # See Koala::Configuration for more options, including details on how to send requests through
      # your own proxy servers.
    end

    Koala::Facebook::API.new(access_token)
  end

  def run

    result = case @post.legacy_capatable_post_type
      when 'gif'
        post_link
      when 'link'
        post_link
      when 'video'
        post_video
      when 'image'
        post_image
      when 'text'
        post_text
      end

    result.inspect
  end

  def post_link
    @graph.put_connections("me", "feed",
      message: @post.legacy_capatable_text,
      link: @post.post_url,
      privacy: {
        value: 'SELF'
      }
    )
  end

  def post_video
    @graph.put_connections("me", "videos",
      description: @post.legacy_capatable_text,
      file_url: 'https://app.houseq.io' + @post.image.url,
      privacy: {
        value: 'SELF'
      }
    )
  end

  def post_image

    data = {
      caption: @post.legacy_capatable_text + '  ' + @post.post_url,
      url: 'https://app.houseq.io' + @post.legacy_capatable_image_url,
      # suburl1: 'https://app.houseq.io' + @post.legacy_capatable_subimage1_url,
      # suburl2: 'https://app.houseq.io' + @post.legacy_capatable_subimage2_url,
      # suburl3: 'https://app.houseq.io' + @post.legacy_capatable_subimage3_url,
      privacy: {
        value: 'SELF'
      }
    }

    data[:link] = @post.post_url if @post.post_url

    @graph.put_connections("me", "photos", data)

   
  end

  def post_text
    @graph.put_connections("me", "feed", message: @post.legacy_capatable_text)
  end
  
end