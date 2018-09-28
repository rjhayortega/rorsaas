module AuthenticationConcern
  extend ActiveSupport::Concern

  included do
    has_secure_password

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
  end

  module ClassMethods
  end
end
