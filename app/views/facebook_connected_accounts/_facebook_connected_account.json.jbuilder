json.extract! facebook_connected_account, :id, :user_id, :verified, :profile_page_id, :facebook_ad_account_id, :created_at, :updated_at
json.url facebook_connected_account_url(facebook_connected_account, format: :json)
