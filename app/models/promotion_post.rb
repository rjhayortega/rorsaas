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

class PromotionPost < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: "User"

  mount_uploader :image, ImageUploader
  mount_uploader :subimage1, ImageUploader
  mount_uploader :subimage2, ImageUploader
  mount_uploader :subimage3, ImageUploader

  scope :active, -> { where("start_date <= ?", Date.today).where("end_date >= ?", Date.today) }

  def mirror_queue_post queue_list_id
    qp = QueuePost.new(
      description: self.description,
      post_url: self.post_url,
      utc_offset: self.utc_offset,
      queue_list_id: queue_list_id,
    )

    qp.remote_image_url = self.image.url if self.image.present?
    qp.remote_subimage1_url = self.subimage1.url if self.subimage1.present?
    qp.remote_subimage2_url = self.subimage2.url if self.subimage2.present?
    qp.remote_subimage3_url = self.subimage3.url if self.subimage3.present?

    qp.save

    QueueList.find(queue_list_id).spread_posts

    qp
  end
end
