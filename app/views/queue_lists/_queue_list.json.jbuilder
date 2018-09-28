json.extract! queue_list, :id, :name, :activity, :image, :started_on, :user_id, :created_at, :updated_at
json.url queue_list_url(queue_list, format: :json)
