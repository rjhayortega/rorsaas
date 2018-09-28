# == Schema Information
#
# Table name: queue_lists
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  activity          :string(255)
#  image             :string(255)
#  started_on        :date
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  queue_posts_count :integer          default(0)
#  ended_on          :date
#

require 'test_helper'

class QueueListTest < ActiveSupport::TestCase
  test "the truth" do
    ql = FactoryGirl.create(:queue_list, started_on: Date.today, user: users(:one), activity: 1)
    2.times { ql.queue_posts << FactoryGirl.build(:queue_post) }
    2.times { ql.profiles << FactoryGirl.build(:profile, user: users(:one)) }
    2.times { ql.profile_pages << FactoryGirl.build(:profile_page, user: users(:one)) }
    p ql.spread_posts
  end
end
