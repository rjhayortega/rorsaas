json.array! @posts.each_with_index.to_a do |(post, index)|
  json.extract! post, :id, :description
  json.start post.scheduled_at.to_date
  json.html render(partial: 'posts/event_html.html.erb', locals: { post: post, posts: @posts, index: index })
end