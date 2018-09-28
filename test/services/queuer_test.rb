require 'test_helper'

class QueuerTest < ActiveSupport::TestCase
  test "#get_posts_count" do
    posts_count = Queuer.get_posts_count 2, "facebook"
    assert_equal 4, posts_count
  end

  test "#create_slots" do
    slots = Queuer.create_slots Date.parse("2017-08-02"), 16
    assert_nil slots.last[:post]
    assert_equal 16, slots.size
  end

  test "#fill_posts_to_slots" do
    posts = (1..5).to_a
    slots = Queuer.create_slots Date.current, 9
    filled_slots = Queuer.fill_posts_to_slots(posts, slots)
    assert_not_nil filled_slots.last[:post]
  end

  test "#fill_posts_to_slots just enough" do
    posts = (1..4).to_a
    slots = Queuer.create_slots Date.current, 4
    filled_slots = Queuer.fill_posts_to_slots(posts, slots)
    assert_not_nil filled_slots.last[:post]
  end

  test "#fill_posts_to_slots less slots" do
    posts = (1..11).to_a
    slots = Queuer.create_slots Date.current, 9
    filled_slots = Queuer.fill_posts_to_slots(posts, slots)
    assert_not_nil filled_slots.last[:post]
  end
end
