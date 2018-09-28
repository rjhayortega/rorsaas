class LinkedinService
  def initialize post, profile
    @post = post
    @profile = profile
  end

  def run
    # resp = if @post.image.present?
    #   if @post.post_type.split('/')[0] == 'video'
    #     post_video
    #   else
    #     post_image
    #   end
    # else
    #   post_text
    # end

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

    # $time_in_seconds = round(1 / 2);

    # exec("ffmpeg -vframes 1 -ss " . $time_in_seconds . " -i " . $video_path . " " . $video_image_dir . $video_name . ".jpg -y 2> " . $video_image_dir . $video_name . ".txt");

    # return resp
    return result
  end

  def post_text
    data = {
      comment: @post.description,
      visibility: {
        code: "anyone"
      }
    }

    api_post data
  end

  def post_link
    data = {
      comment: @post.description,
      content: {
        title: "HouseQ",
        description: 'Click on the Image to see the full version.',
        'submitted-url': @post.post_url,
        'submitted-image-url': @post.other_image_url
      },
      visibility: {
        code: "anyone"
      }
    }

    api_post data
  end

  def post_image

    data = {
      comment: @post.description,
      content: {
        title: "Image",
        description: 'Click on the image to see full version.',
        'submitted-url': 'https://app.houseq.io' + @post.image.url,
        'submitted-image-url': 'https://app.houseq.io' + @post.image.url,
      },
      visibility: {
        code: "anyone"
      }
    }

    api_post data
  end

  def post_video
    data = {
      comment: @post.description,
      content: {
        title: "Video shared",
        description: 'Click on the image to see full version.',
        'submitted-url': 'https://app.houseq.io' + @post.image.url,
        'submitted-image-url': 'https://app.houseq.io' + @post.image.url,
      },
      visibility: {
        code: "anyone"
      }
    }

    api_post data
  end

  private

    def api_post data
      @url ||= if @profile.is_a?(ProfilePage)
        "https://api.linkedin.com/v1/companies/#{@profile.page_id}/shares?format=json"
      else
        'https://api.linkedin.com/v1/people/~/shares?format=json'
      end

      @access_token ||= if @profile.is_a?(ProfilePage)
        # It's actually a ProfilePage
        @profile.profile.access_token
      else
        @profile.access_token
      end

      Typhoeus.post(@url,
        headers: {
          Authorization: 'Bearer ' + @access_token,
          "Content-Type": "application/json"
        },
        body: data.to_json
      ).body
    end
end