# == Schema Information
#
# Table name: post_profile_pages
#
#  id             :integer          not null, primary key
#  post_id        :integer
#  knack_pages_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class PostProfilePage < ApplicationRecord
  belongs_to :post
  belongs_to :profile_page, foreign_key: :knack_pages_id
end
