json.extract! profile, :id, :network, :social_account_id
json.profile_image profile.profile_pic
json.name [profile.fname, profile.lname].join(' ')

if local_assigns[:checked].present?
  json.checked checked
else
  json.checked false
end