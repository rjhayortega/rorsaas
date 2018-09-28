# == Schema Information
#
# Table name: facebook_connected_accounts
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  verified               :boolean          default(FALSE)
#  profile_page_id        :integer
#  facebook_ad_account_id :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

FactoryGirl.define do
  factory :facebook_connected_account do
    user nil
    verified false
    profile_page nil
    facebook_ad_account_id "MyString"
  end
end
