# == Schema Information
#
# Table name: offices
#
#  id                             :integer          not null, primary key
#  name                           :string(255)
#  organisation_id                :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  users_count                    :integer          default(0)
#  maximum_users_count            :integer          default(10000)
#  payer_id                       :integer
#  stripe_manager_subscription_id :string(255)
#  stripe_agents_subscription_id  :string(255)
#  stripe_customer_id             :string(255)
#

require 'test_helper'

class OfficeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
