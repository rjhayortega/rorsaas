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

class FacebookConnectedAccount < ApplicationRecord
  belongs_to :user
  belongs_to :profile_page
  has_many :facebook_ads
end
