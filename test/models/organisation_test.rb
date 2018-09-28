# == Schema Information
#
# Table name: organisations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  users_count :integer          default(0)
#

require 'test_helper'

class OrganisationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
