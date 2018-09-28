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

require 'test_helper'

class PromotionPostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
