# == Schema Information
#
# Table name: knack_pages
#
#  id            :integer          not null, primary key
#  page_id       :string(200)      not null
#  page_name     :string(250)      not null
#  profile_image :text(65535)      not null
#  connect       :integer          not null
#  access_token  :text(65535)      not null
#  profile_id    :string(300)      not null
#  user_id       :integer          not null
#  network       :string(250)      not null
#  page_type     :string(126)      not null
#  org_id        :string(100)      not null
#  houseq        :string(11)       not null
#  connect_ads   :string(30)       not null
#  token_expired :integer          not null
#  error         :text(65535)      not null
#  disable_que   :integer          not null
#

class ProfilePage < ApplicationRecord
  self.table_name = 'knack_pages'

  has_many :post_profile_pages, dependent: :destroy, foreign_key: :knack_pages_id
  has_many :posts, through: :post_profile_pages, dependent: :destroy

  belongs_to :user
  belongs_to :profile, primary_key: "profile_id"

  alias_attribute :social_account_id, :page_id
  alias_attribute :image, :profile_image
  alias_attribute :name, :page_name
  alias_attribute :fname, :page_name

  scope :only_facebook, -> { where(network: "facebook") }


  def profile_pic_with_default
    profile_pic
  end

  def profile_pic
    profile_image.presence || 'linkedin_profile_picture.png'
  end

  def handle
    nil
  end
end
