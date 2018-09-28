FactoryGirl.define do
  factory :user do
    first_name  'Hsu'
    last_name  'Pan'
    sequence :email do |n|
      'factory-girl#{n}.1up@0sg.net'
    end
    encrypted_password  'KnV2c0hvenJBZzg2WXItbjRz'
    password  'KnV2c0hvenJBZzg2WXItbjRz'
    password_confirmation  'KnV2c0hvenJBZzg2WXItbjRz'
    user_type  'Premium Account'
    authentication_token  'CPxB8S5LuGMjRfomrs9Z'
  end
end
