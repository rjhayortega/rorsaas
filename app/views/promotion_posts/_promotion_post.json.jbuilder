json.extract! promotion_post, :id, :description, :post_url, :utc_offset, :image, :subimage1, :subimage2, :subimage3, :author_id, :created_at, :updated_at
json.url promotion_post_url(promotion_post, format: :json)
