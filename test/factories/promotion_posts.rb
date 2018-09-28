# == Schema Information
#
# Table name: promotion_posts
#
#  id          :integer          not null, primary key
#  description :text(65535)
#  post_url    :string(255)
#  utc_offset  :string(255)
#  image       :string(255)
#  subimage1   :string(255)
#  subimage2   :string(255)
#  subimage3   :string(255)
#  author_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  start_date  :date
#  end_date    :date
#

FactoryGirl.define do
  factory :promotion_post do
    description "MyText"
    post_url "MyString"
    utc_offset "MyString"
    image "MyString"
    subimage1 "MyString"
    subimage2 "MyString"
    subimage3 "MyString"
    author nil
  end
end
