class Content < ApplicationRecord
  validates :charge_id, presence: true
  belongs_to :user
end
