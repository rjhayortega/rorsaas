# == Schema Information
#
# Table name: organisations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  users_count :integer          default(0)
#

class Organisation < ApplicationRecord
  validates :name, presence: true
  has_many :users
  has_many :offices
end
