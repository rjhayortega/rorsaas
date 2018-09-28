# == Schema Information
#
# Table name: profile_queue_lists
#
#  id            :integer          not null, primary key
#  profile_id    :integer
#  queue_list_id :integer
#

class ProfileQueueList < ApplicationRecord
  belongs_to :queue_list
  belongs_to :profile
end
