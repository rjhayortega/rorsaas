FactoryGirl.define do
  factory :queue_post do
  end

  factory :profile do
    network 'twitter'
  end

  factory :profile_page do
    network 'twitter'
  end
end
