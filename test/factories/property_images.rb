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

FactoryGirl.define do
  factory :property_image do
    file "MyString"
    property nil
  end
end
