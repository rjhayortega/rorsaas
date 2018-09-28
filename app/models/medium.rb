class Medium < ApplicationRecord
  mount_uploader :file, MediumUploader

  belongs_to :folder
end
