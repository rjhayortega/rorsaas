# == Schema Information
#
# Table name: properties
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  description           :text(65535)
#  address               :string(255)
#  user_id               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  price                 :float(24)
#  logo                  :string(255)
#  property_images_count :integer
#  agent_id              :integer
#  slug                  :string(255)      not null
#  address2              :string(255)
#  country               :string(255)
#  beds                  :integer          default(0)
#  bath                  :integer          default(0)
#  parking               :integer          default(0)
#  is_rent               :boolean          default(FALSE)
#  shares_count          :integer          default(0)
#  visits_count          :integer          default(0)
#

require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
