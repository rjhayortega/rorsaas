require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  test "admin can only destroy projects which they own" do
    ability = Ability.new(users(:admin))

    assert ability.can?(:create, Organisation)
    assert ability.can?(:manage, Office.new())
    assert ability.can?(:manage, User.new())
  end

  test "office can only destroy projects which they own" do
    ability = Ability.new(users(:office))

    assert ability.cannot?(:create, Organisation)
    assert ability.cannot?(:read, Office)
    assert ability.cannot?(:create, Office)
    assert ability.can?(:create, User)
  end

  test "agent can only destroy projects which they own" do
    ability = Ability.new(users(:agent))

    assert ability.cannot?(:create, Organisation)
    assert ability.cannot?(:create, Office)
    assert ability.cannot?(:create, User)
  end
end
