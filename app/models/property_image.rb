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

class PropertyImage < ApplicationRecord
  belongs_to :property, counter_cache: true
  mount_uploader :file, PropertyImageUploader
end
