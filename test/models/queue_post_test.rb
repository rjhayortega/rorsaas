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

require 'test_helper'

class QueuePostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
