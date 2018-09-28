# == Schema Information
#
# Table name: agents
#
#  id         :integer          not null, primary key
#  photo      :string(255)
#  first_name :string(255)
#  email      :string(255)
#  phone      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  last_name  :string(255)
#

class Agent < ApplicationRecord
  belongs_to :user
  mount_uploader :photo, AgentPhotoUploader
  validates :photo, :first_name, :last_name, presence: true

  def full_name
    [first_name, last_name].join(' ')
  end
end
