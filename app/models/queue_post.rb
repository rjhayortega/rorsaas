# == Schema Information
#
# Table name: queue_posts
#
#  id              :integer          not null, primary key
#  description     :text(65535)
#  post_url        :string(255)
#  utc_offset      :string(255)
#  queue_post      :string(255)
#  image           :string(255)
#  subimage1       :string(255)
#  subimage2       :string(255)
#  subimage3       :string(255)
#  queue_list_id   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  other_image_url :string(255)
#

class QueuePost < ApplicationRecord
  belongs_to :queue_list, counter_cache: true

  mount_uploader :image, ImageUploader
  mount_uploader :subimage1, ImageUploader
  mount_uploader :subimage2, ImageUploader
  mount_uploader :subimage3, ImageUploader

  after_save :spread_posts
  has_many :posts, dependent: :destroy

  def spread_posts

    self.queue_list.spread_posts

  end


end
