# json.partial! "posts/post", post: @post
json.text ''
json.image ''
json.scheduled_at DateTime.current.utc
json.profiles current_user.profiles do |profile|
  json.partial! "profiles/profile", profile: profile
end

json.pages current_user.profile_pages do |page|
  json.partial! "profiles/page", profile: page
end