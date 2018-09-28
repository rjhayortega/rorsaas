# == Schema Information
#
# Table name: knack_profiles
#
#  id              :integer          not null, primary key
#  network_id      :string(200)      not null
#  profile_email   :string(300)      not null
#  network         :string(250)      not null
#  fname           :string(300)      not null
#  lname           :string(300)      not null
#  profile_pic     :text(65535)      not null
#  profile_id      :string(300)      not null
#  access_token    :text(65535)      not null
#  refresh_token   :text(65535)      not null
#  long_live_token :string(500)      not null
#  followers       :integer          not null
#  following       :integer          not null
#  others          :integer          not null
#  user_id         :integer          not null
#  expires_in      :string(100)      not null
#  expires_at      :string(100)      not null
#  org_id          :string(20)       not null
#  password        :string(50)       not null
#  username        :string(50)       not null
#  houseq          :integer          not null
#  token_expired   :integer          not null
#  error           :text(65535)      not null
#  disable_que     :integer          not null
#  verified        :boolean          default(FALSE)
#

class Profile < ApplicationRecord
  self.table_name = 'knack_profiles'

  has_many :post_profiles, dependent: :destroy, foreign_key: :knack_profiles_id
  has_many :posts, through: :post_profiles, dependent: :destroy

  belongs_to :user

  alias_attribute :social_account_id, :profile_id
  alias_attribute :image, :profile_pic
  alias_attribute :name, :fname

  def profile_pic_with_default
    profile_pic.presence || 'linkedin_profile_picture.png'
  end

  def handle
    case network
    when 'twitter'
      profile_id
    when 'instagram'
      fname
    else
      nil
    end
  end
end
