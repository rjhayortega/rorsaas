class Folder < ApplicationRecord
  self.table_name = 'knack_folders'
  validates_presence_of :name

  belongs_to :user
  has_many :media, dependent: :destroy
end
