# == Schema Information
#
# Table name: agents
#
#  id         :integer          not null, primary key
#  photo      :string(255)
#  first_name :string(255)
#  email      :string(255)
#  phone      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  last_name  :string(255)
#

require 'test_helper'

class AgentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
