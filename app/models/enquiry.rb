# == Schema Information
#
# Table name: enquiries
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  phone       :string(255)
#  email       :string(255)
#  postcode    :string(255)
#  message     :text(65535)
#  agent_id    :integer
#  property_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Enquiry < ApplicationRecord
  belongs_to :agent
  belongs_to :property
end
