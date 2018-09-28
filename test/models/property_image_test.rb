# == Schema Information
#
# Table name: property_images
#
#  id          :integer          not null, primary key
#  file        :string(255)
#  property_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class PropertyImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
