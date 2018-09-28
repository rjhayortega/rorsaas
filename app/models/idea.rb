# == Schema Information
#
# Table name: knack_discover_search_datas
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  team_member_id   :integer          not null
#  team_post        :integer          not null
#  team_post_type   :string(30)       not null
#  network          :string(30)       not null
#  search_type      :string(30)       not null
#  keyword          :string(30)       not null
#  name             :string(50)       not null
#  profile_url      :string(200)      not null
#  link             :string(200)      not null
#  text             :string(1000)     not null
#  likes_count      :string(10)       not null
#  img_url          :string(300)      not null
#  video_url        :string(300)      not null
#  media_count      :string(10)       not null
#  followers        :string(10)       not null
#  following        :string(10)       not null
#  category         :string(200)      not null
#  favourites_count :string(10)       not null
#  created_at       :string(50)       not null
#  category_assign  :string(30)       not null
#  category_text    :text(65535)      not null
#  image_upload     :string(200)      not null
#  suggested_date   :string(20)       not null
#  org_id           :string(20)       not null
#

class Idea < ApplicationRecord
  self.table_name = 'knack_discover_search_datas'
  belongs_to :user
end
