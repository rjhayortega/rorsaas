# == Schema Information
#
# Table name: facebook_ads
#
#  id                            :integer          not null, primary key
#  campaign_name                 :string(255)
#  objective                     :string(255)
#  audience_location             :string(255)
#  audience_group                :string(255)
#  gender_preference             :string(255)
#  detail                        :text(65535)
#  total_budget                  :string(255)
#  start_on                      :date
#  finish_on                     :date
#  url                           :string(255)
#  headline                      :string(255)
#  best_pitch                    :string(255)
#  image                         :string(255)
#  facebook_connected_account_id :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  page_id                       :integer
#

class FacebookAd < ApplicationRecord
  belongs_to :facebook_connected_account
  belongs_to :page, class_name: "ProfilePage"

  validates :campaign_name, presence: true
  mount_uploader :image, FacebookAdsUploader
end
