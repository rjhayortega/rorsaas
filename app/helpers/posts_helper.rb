module PostsHelper
  def attrs_for_display
    [
      :description,
      :post_url,
      :post_img,
    ]
  end

  def determine_submit_button_text post, queue_list
    return 'Add to queue' if queue_list.present?
    return 'Save for later' if post.is_draft?
    return 'Publish'
  end
end
