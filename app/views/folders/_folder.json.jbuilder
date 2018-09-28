json.extract! folder, :id, :name, :user_id, :created_at, :updated_at
json.url folder_url(folder, format: :json)
json.media folder.media, partial: "media/medium", as: :medium
json.cover folder.media.size > 0 ? folder.media[0].file.url : "https://pbs.twimg.com/media/C8ezMTGXYAQIx8-.jpg"
