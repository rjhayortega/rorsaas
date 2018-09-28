# == Schema Information
#
# Table name: post_profiles
#
#  id                :integer          not null, primary key
#  post_id           :integer
#  knack_profiles_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class PostProfile < ApplicationRecord
  belongs_to :post
  belongs_to :profile, foreign_key: :knack_profiles_id
end
