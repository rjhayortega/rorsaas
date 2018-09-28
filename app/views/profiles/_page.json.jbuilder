json.extract! profile, :id, :page_id, :profile_image, :network, :profile_id
json.name profile.page_name
json.profile_image ensure_profile_image(profile)

if local_assigns[:checked].present?
  json.checked checked
else
  json.checked false
end