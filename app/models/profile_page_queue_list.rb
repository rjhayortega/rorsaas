# == Schema Information
#
# Table name: profile_page_queue_lists
#
#  id              :integer          not null, primary key
#  profile_page_id :integer
#  queue_list_id   :integer
#

class ProfilePageQueueList < ApplicationRecord
  belongs_to :queue_list
  belongs_to :profile_page
end
