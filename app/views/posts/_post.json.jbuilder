json.extract! post, :id, :description
json.start post.scheduled_at.to_date
json.html render(partial: 'posts/event_html.html.erb', locals: { post: post })

# json.tasks post.post_tasks do |task|
#   json.extract! task, :id
#   json.profile do
#     json.profile_id task.profilable.profile_id
#     json.name task.profilable.name
#     json.image task.profilable.image
#     json.network task.profilable.network
#   end
# end

# json.profiles post.profiles do |profile|
#   json.profile_id profile.profile_id
#   json.name profile.name
#   json.image profile.image
#   json.network profile.network
# end
