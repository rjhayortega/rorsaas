# json.partial! "posts/post", post: @post
json.text @post.content
json.image @post.image
json.profiles @post.user.profiles do |profile|
  json.partial! "profiles/profile", profile: profile, checked: profile.id.in?(@post.profile_ids)
end

json.pages @post.user.profile_pages do |page|
  json.partial! "profiles/page", profile: page, checked: page.id.in?(@post.page_ids)
end

json.scheduled_at @post.scheduled_at.localtime(@post.utc_offset)

json.selectedMedia do
  json.file @post.image
  json.content_type @post.post_type
end

json.previewData do
  json.networks (@post.pages.map(&:network) + @post.profiles.map(&:network)).uniq
  json.text @post.content
  json.image @post.image
end

# {
#   previewData: {
#     text: '',
#     image: '',
#     facebook: {
#       name: "",
#       profile_image: "",
#     },
#     twitter: {
#       name: "",
#       profile_image: "",
#     },
#     instagram: {
#       name: "",
#       profile_image: "",
#     },
#     linkedin: {
#       name: "",
#       profile_image: "",
#     },
#   }
# }