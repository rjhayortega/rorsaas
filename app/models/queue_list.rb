# == Schema Information
#
# Table name: queue_lists
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  activity          :string(255)
#  image             :string(255)
#  started_on        :date
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  queue_posts_count :integer          default(0)
#  ended_on          :date
#

class QueueList < ApplicationRecord
  belongs_to :user
  mount_uploader :image, QueueListCoverUploader

  has_many :profile_page_queue_lists, dependent: :destroy
  has_many :profile_pages, through: :profile_page_queue_lists

  has_many :profile_queue_lists, dependent: :destroy
  has_many :profiles, through: :profile_queue_lists

  has_many :posts, dependent: :destroy
  has_many :queue_posts, dependent: :destroy

  after_update :spread_posts
  after_create :update_ended_on

  def spread_posts
    if self.queue_posts.any?
      self.posts.destroy_all

      posts_array = self.queue_posts.map do |qp|
        extra = {id: nil, queue_post_id: qp.id}

        if qp.image.present?

          extra[:image] = File.open(qp.image.file.path)
        end

        qp.attributes.merge(extra)
      end
      (self.profiles + self.profile_pages).each do |profile|
        posts_count = Queuer.get_weekly_posts_count self.activity, profile.network

        slots = Queuer.create_slots self.started_on, self.ended_on, posts_count, self.activity
        filled_slots = Queuer.fill_posts_to_slots(posts_array, slots)
        filled_slots.each do |slot|
          extra = {
            scheduled_at: slot[:time],
            # profile_ids: self.profile_ids,
            # page_ids: self.profile_page_ids,
            user: self.user,
          }

          if profile.is_a? Profile
            extra[:profile_ids] = [profile.id]
          else
            extra[:page_ids] = [profile.id]
          end

          post = self.posts.new slot[:post].merge(extra)

          post.fill_garbage
          post.save
          post.fill_post_img
        end
      end
    end
  end

  def smart_image_url

    if self.img.present? && !self.img.include?('http')
      "https://app.houseq.io/upload_files/post/" + self.img
    else
      self.img
    end
  end

  private

  def update_ended_on
    update_column :ended_on, started_on + 1.day
  end
end
