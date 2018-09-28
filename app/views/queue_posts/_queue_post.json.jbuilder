json.extract! queue_post, :id, :description, :post_url, :utc_offset, :queue_post, :image, :subimage1, :subimage2, :subimage3, :queue_list_id, :created_at, :updated_at
json.url queue_post_url(queue_post, format: :json)
